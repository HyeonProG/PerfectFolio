package com.tenco.perfectfolio.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.dto.ValidationCodeDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.service.EmailService;
import com.tenco.perfectfolio.service.UserService;
import com.tenco.perfectfolio.utils.Define;
import com.tenco.perfectfolio.utils.ValidationUtil;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/send-mail")
@Controller
@RequiredArgsConstructor
public class EmailController {

	@Autowired
	private EmailService emailService;

	@Autowired
	private UserService userService;
	@Autowired
	private HttpSession session;
	private static long sentTime = 0;
	private static long currentTime = 0;
	private final long MAX_VALIDATE_TIME = 180000;
	private boolean isValidated = false;

	@GetMapping("/emailPage")
	public String sendEmailPage() {
		System.out.println("EmailPage 들어옴");
		return "user/sendEmail";
	}

	/**
	 * ****** !이메일 인증 로직 시작! ****** signUp.jsp에서 발송 버튼을 누르면 email의 값을 fetch를 통해
	 * 받아옵니다.
	 * 
	 * @param email = client 에서 던진 email 값을 받습니다.
	 * @return ResponseEntity = client 측에게 알맞은 response 를 전달
	 */
	@GetMapping("/email")
	public ResponseEntity<Map<String, String>> sendCode(@RequestParam("email") String email,
			ValidationCodeDTO validationCodeDTO) {
		// UUID 랜덤 코드 생성
		String emailValidationCode = UUID.randomUUID().toString();
		// validationCode 를 위의 랜덤 코드로 설정
		validationCodeDTO.setValidationCode(emailValidationCode);
		// 유효성 검사, 형식 검증 또는 발송 성공에 대한 response를 Map 자료구조를 사용해서 생성합니다.
		Map<String, String> response = new HashMap<>();
		// SELECT 문을 실행시켜서 결과가 있다면 1(중복 O), 결과가 없다면 0(중복 X)
		int result = userService.checkDuplicateEmail(email);

		if (result != 0) {
			response.put("message", "동일한 E-mail로는 중복 가입할 수 없습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		// 이메일 유효성 검사
		if (email == null || email.trim().isEmpty()) {

			// 빈값에 대한 response 생성
			response.put("message", "E-mail을 입력해주세요.");
			return ResponseEntity.badRequest().body(response);
		}

		// 이메일 형식 검증 (간단한 정규 표현식 사용)
		if (!email.matches("^[\\w-_.+]*[\\w-_.]@[\\w]+\\.[a-zA-Z]{2,}$")) {
			System.out.println("유효하지 않은 곳에 들어왔습니다.");

			// 유효하지 않다는 response 생성
			response.put("message", "유효하지 않은 E-mail입니다.");
			return ResponseEntity.badRequest().body(response);
		}
		// 발송 버튼을 누른 순간의 시간을 기록합니다.
		sentTime = System.currentTimeMillis();

		// E-mail을 전송합니다. (수신자, 제목, 내용)
		emailService.sendMail(email, "이메일 인증번호", "sendValidateCode", emailValidationCode);
		response.put("message", "인증 코드를 발송하였습니다.");
		return ResponseEntity.ok(response);

	}

	/**
	 * !! 메일로 보내진 인증 버튼을 타고 들어오면 해당 메소드에 오게 됩니다.
	 * 
	 * @param userValidationCode = client 측에서 전송한 validationCode 입니다
	 * @param validationCodeDTO  = DTO 에 저장되어있는 validationCode 입니다.
	 * @return .jsp = 결과에 맞는 JSP 를 보냅니다. (validatePage or emailErrorPage)
	 */
	@GetMapping("/validate/{validationCode}")
	public String validateUserCode(ValidationCodeDTO validationCodeDTO,
			@PathVariable("validationCode") String userValidationCode) {

		// 이메일 내에서 인증 버튼을 누른 순간의 시간을 기록합니다
		currentTime = System.currentTimeMillis();

		// ValidationDTO 에 저장된 validationCode 를 가져옵니다
		String dtoValidationCode = validationCodeDTO.getValidationCode();

		// 현재시간 - 발송시간 > 3분(180,000Millis)
		boolean isExpired = validationCodeDTO.isExpired(currentTime, sentTime, MAX_VALIDATE_TIME);

		if (isExpired) {
			// 만료가 됐다면 DTO 에 있는 validationCode 를 null 로 설정합니다
			validationCodeDTO.setValidationCode(null);
		}

		if (dtoValidationCode == null || userValidationCode.equals("") || userValidationCode.trim().isEmpty()) {
			return "error/emailErrorPage";
		}
		isValidated = true;
		return "user/validatePage";
	}

	/**
	 * ****** !비밀번호 재설정을 위한 인증 로직 시작! ******
	 * 
	 * @param email             = client 에서 fetch 를 통해 날라온 email 을 받아옵니다
	 * @param validationCodeDTO = 인증 코드를 저장합니다
	 * @return ResponseEntity = client 측에게 response 를 전달
	 */
	@GetMapping("/findPasswordByEmail")
	public ResponseEntity<Map<String, String>> findPasswordByEmail(@RequestParam("email") String email,
			ValidationCodeDTO validationCodeDTO) {
		String findPasswordByEmailCode = UUID.randomUUID().toString();
		validationCodeDTO.setValidationCode(findPasswordByEmailCode);
		// 유효성 검사, 형식 검증 또는 발송 성공에 대한 response를 Map 자료구조를 사용해서 생성합니다.
		Map<String, String> response = new HashMap<>();
		// SELECT 문을 실행시켜서 결과가 있다면 1(중복 O), 결과가 없다면 0(중복 X)
		int result = userService.checkDuplicateEmail(email);

		if (result == 0) {
			response.put("message", "해당 유저가 존재하지 않습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		// 이메일 유효성 검사
		if (email == null || email.trim().isEmpty()) {
			System.out.println("빈칸에 들어왔습니다.");

			// 빈값에 대한 response 생성
			response.put("message", "E-mail을 입력해주세요.");
			return ResponseEntity.badRequest().body(response);
		}

		// 이메일 형식 검증 (간단한 정규 표현식 사용)
		if (!email.matches("^[\\w-_.+]*[\\w-_.]@[\\w]+\\.[a-zA-Z]{2,}$")) {
			System.out.println("유효하지 않은 곳에 들어왔습니다.");

			// 유효하지 않다는 response 생성
			response.put("message", "유효하지 않은 E-mail입니다.");
			return ResponseEntity.badRequest().body(response);
		}
		
		ValidationCodeDTO.builder().email(email).validationCode(findPasswordByEmailCode)
				.expirationTime(MAX_VALIDATE_TIME).build();

		// E-mail을 전송합니다. (수신자, 제목, 내용)
		sentTime = System.currentTimeMillis();
		emailService.sendMail(email, "비밀번호 변경을 위한 이메일 인증", "findPasswordByEmail", findPasswordByEmailCode);
		response.put("message", "인증 코드를 발송하였습니다.");
		return ResponseEntity.ok(response);

	}

	/**
	 * 비밀번호 재설정을 위해 전송된 이메일에서, 인증 버튼을 누른다면 실행됩니다.
	 * 
	 * @param userValidationCode = client 측에서 전송한 validationCode 입니다
	 * @param validationCodeDTO  = DTO 에 저장된 validationCode 입니다
	 * @return .jsp = 결과에 맞는 JSP 를 보냅니다 (changePassword or emailErrorPage)
	 */
	@GetMapping("validateForPassword/{validationCode}")
	public String validateForPassword(@PathVariable("validationCode") String userValidationCode,
			ValidationCodeDTO validationCodeDTO) {
		currentTime = System.currentTimeMillis();
		String dtoValidationCode = validationCodeDTO.getValidationCode();

		boolean isExpired = validationCodeDTO.isExpired(currentTime, sentTime, MAX_VALIDATE_TIME);

		if (isExpired) {
			validationCodeDTO.setValidationCode(null);
		}

		if (dtoValidationCode == null || userValidationCode == null || userValidationCode.trim().isEmpty()) {
			return "error/emailErrorPage";
		}

		return "user/changePassword";
	}

	@GetMapping("/checkValidate")
	public ResponseEntity<Map<String, String>> checkValidate() {
		Map<String, String> response = new HashMap<>();

		if (!isValidated) {
			response.put("message", "인증이 완료되지 않았습니다. 이메일을 확인해주세요.");
			return ResponseEntity.badRequest().body(response);
		}
		response.put("message", "인증이 완료되었습니다.");
		return ResponseEntity.ok(response);
	}

	/**
	 * 아이디 찾기를 위한 이메일 전송 로직
	 * 
	 * @param email
	 * @return
	 */
	@GetMapping("/findUserIdByEmail")
	public ResponseEntity<Map<String, String>> findUserIdByEmail(@RequestParam("email") String email) {

		Map<String, String> response = new HashMap<>();

		// 이메일 유효성 검사
		if (email == null || email.trim().isEmpty()) {
			response.put("message", "E-mail을 입력해주세요.");
			return ResponseEntity.badRequest().body(response);
		}

		if (!ValidationUtil.isValidateEmail(email)) {
			response.put("message", "올바른 이메일 형식을 입력해주세요.");
			return ResponseEntity.badRequest().body(response);
		}

		// 사용자 아이디 검색
		PrincipalDTO dto = userService.searchUserEmail(email);
		if (dto == null) {
			response.put("message", "해당 이메일로 등록된 아이디가 없습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		if (!"local".equalsIgnoreCase(dto.getUserSocialType())) {
			response.put("message", "해당 이메일로 등록된 회원이 없습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		// 이메일로 아이디 전송
		emailService.sendMailByUserId(email, "아이디 찾기", dto);

		// 성공적인 응답
		response.put("message", "이메일을 발송했습니다. 아이디는 이메일을 통해 확인해 주세요.");
		return ResponseEntity.ok(response);
	}

}
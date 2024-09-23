package com.tenco.perfectfolio.controller;

import com.tenco.perfectfolio.dto.*;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.model.Portfolio;
import com.tenco.perfectfolio.repository.model.RecommendCompanies;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.payment.Subscribing;
import com.tenco.perfectfolio.service.*;
import com.tenco.perfectfolio.utils.Define;
import com.tenco.perfectfolio.utils.ValidationUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

	@Autowired
	private final UserService userService;
	@Autowired
	private final JobNoticeService jobNoticeService;
	@Autowired
	private HttpSession session;
	@Autowired
	private PortfolioService portfolioService;
	@Value("${naver.client-id}")
	private String naverClientId;
	@Value("${naver.client-secret}")
	private String naverClientSecret;
	@Value("${naver.redirect-uri}")
	private String naverRedirectUri;

	private final String naverGrantTypeIssue = "authorization_code";
	private final String naverGrantTypeRefresh = "refresh_token";
	private final String naverGrantTypeDelete = "delete";

	@Value("${kakao.client-id}")
	private String kakaoClientId;
	@Value("${kakao.redirect-uri}")
	private String kakaoRedirectUri;
	private KakaoUserInfoDTO kakaoUserInfoDTO;

	@Value("${google.client-id}")
	private String googleClientId;
	@Value("${google.client-secret}")
	private String googleClientSecret;
	@Value("${google.grant-type}")
	private String googleGrantType;
	@Value("${google.redirect-uri}")
	private String googleRedirectUri;
	private GoogleUserInfoDTO googleUserInfoDTO; // TODO - 클래스 이름 변경 필수!

	// TODO - 소셜 로그인 전략 패턴으로 전환
	private String accessToken = "";
	private String httpHeader = "Bearer " + accessToken; // Bearer 다음에 공백 추가

	@Autowired
	private final PasswordEncoder passwordEncoder;

	@Autowired
	private final NoticeService noticeService;
	
	@Autowired
	private final PaymentService paymentService;
	
	@GetMapping("/main")
	public String mainPage(Model model) {
		List<CountResultDTO> countList = userService.getTodayCountResult();
		model.addAttribute("totalMatch", countList.get(0).getCount());
		model.addAttribute("todayMatch", countList.get(1).getCount() != null ? countList.get(1).getCount() : "0");
		model.addAttribute("totalNotice", countList.get(2).getCount());
		model.addAttribute("todayNotice", countList.get(3).getCount());
		return "main";
	}

	/**
	 * 네이버 소셜 로그인시 필요한 state CSRF 공격을 방지하기 위한 랜덤 문자열을 생성합니다.
	 * 
	 * @return
	 */
	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

	// 회원가입 파트 시작

	/**
	 * 회원가입 방식 선택 페이지 http://localhost:8080/user/intro-sign-up
	 * 
	 * @return introSignUp.jsp
	 */
	@GetMapping("/intro-sign-up")
	public String introSignUpPage() {
		return "user/introSignUp";
	}

	/**
	 * 로컬 회원가입 페이지 http://localhost:8080/user/sign-up
	 * 
	 * @return signUp.jsp
	 */
	@GetMapping("/sign-up")
	public String signUpPage(Model model) {
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		model.addAttribute("naverClientId", naverClientId);
		model.addAttribute("naverRedirectUri", naverRedirectUri);
		model.addAttribute("state", state);

		model.addAttribute("kakaoRestApiKey", kakaoClientId);
		model.addAttribute("kakaoRedirectUri", kakaoRedirectUri);

		model.addAttribute("googleClientId", googleClientId);
		model.addAttribute("googleRedirectUri", googleRedirectUri);
		return "user/signUp";
	}

	/**
	 * 아이디 중복 체크 로직
	 * 
	 * @param userId
	 * @return
	 */
	@GetMapping("/checkId")
	public ResponseEntity<Map<String, String>> checkDuplicate(@RequestParam("userId") String userId) {
		Map<String, String> response = new HashMap<>();

		int result = userService.checkDuplicateID(userId);

		if (result != 0) {
			System.out.println("중복된 아이디");
			response.put("message", "중복된 ID는 사용할 수 없습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		response.put("message", "사용 가능한 ID입니다.");
		return ResponseEntity.ok(response);
	}

	/**
	 * 회원 가입 로직 http://localhost:8080/user/sign-up
	 * 
	 * @return signUp.jsp
	 */
	@PostMapping("/sign-up")
	public String signUpProc(SignUpDTO dto) {
		
		String userId = dto.getUserId();
		String username = dto.getUsername();
		String userpwd = dto.getUserPassword();
		String userpwdCheck = dto.getPasswordCheck();
		String userEmail = dto.getUserEmail();
		String userBirth = dto.getUserBirth();
		String userGender = dto.getUserGender();
		String userTel = dto.getUserTel();

		 // 성별이 null이거나 빈 값일 경우 '설정안함'으로 설정
	    if (userGender == null || userGender.trim().isEmpty()) {
	        userGender = "설정안함";
	        dto.setUserGender(userGender);
	    }
		
		// 유효성 검사
		if (!ValidationUtil.isValidateName(username)) {
			throw new DataDeliveryException(Define.SIGNUP_NAME, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateId(userId)) {
			throw new DataDeliveryException(Define.SIGNUP_ID, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidatePwd(userpwd)) {
			throw new DataDeliveryException(Define.SIGNUP_PWD, HttpStatus.BAD_REQUEST);
		}
		// 비밀번호와 확인 비밀번호가 일치하지 않을 때
		if (!userpwd.equals(userpwdCheck)) {
			throw new DataDeliveryException(Define.SIGNIN_PWD_AGAIN, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateEmail(userEmail)) {
			throw new DataDeliveryException(Define.SIGNUP_EMAIL, HttpStatus.BAD_REQUEST);
		}
		if (userBirth == null || userBirth.trim().isEmpty()) {
			throw new DataDeliveryException(Define.SIGNUP_BIRTH, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateTel(userTel)) {
			throw new DataDeliveryException(Define.SIGNUP_TEL, HttpStatus.BAD_REQUEST);
		}

		userService.createUser(dto);
		return "redirect:/user/sign-in";
	}

	// 로그인 파트 시작

	/**
	 * 로그인 페이지 http://localhost:8080/user/sign-in
	 * 
	 * @return signIn.jsp
	 */
	@GetMapping("/sign-in")
	public String signInPage(Model model) {
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		model.addAttribute("naverClientId", naverClientId);
		model.addAttribute("naverRedirectUri", naverRedirectUri);
		model.addAttribute("state", state);

		model.addAttribute("kakaoRestApiKey", kakaoClientId);
		model.addAttribute("kakaoRedirectUri", kakaoRedirectUri);

		model.addAttribute("googleClientId", googleClientId);
		model.addAttribute("googleRedirectUri", googleRedirectUri);
		return "user/signIn";
	}

	/**
	 * 로컬 로그인 요청 처리 http://localhost:8080/user/sign-in
	 * 
	 * @return
	 */
	@PostMapping("/sign-in")
	public String signProc(HttpServletRequest request, SignInDTO dto, User user) throws IOException {

		String userId = dto.getUserId();
		String userpwd = dto.getUserPassword();

		// 유효성 검사
		if (!ValidationUtil.isValidateId(userId)) {
			throw new DataDeliveryException(Define.SIGNIN_ID, HttpStatus.BAD_REQUEST);
		}
		if (userpwd == null || userpwd.trim().isEmpty()) {
			throw new DataDeliveryException(Define.SIGNIN_PWD, HttpStatus.BAD_REQUEST);
		}

		// 유효한 유저인지 확인
		PrincipalDTO principal = userService.searchUserId(userId);
		if (principal == null) {
			throw new DataDeliveryException(Define.LOGIN_USER_NOT_EXIST, HttpStatus.BAD_REQUEST);
		}

		// 입력한 비밀번호와 DB의 비밀번호가 동일한지 확인
		user = userService.searchUserIdByUser(userId);
		if (user != null) {
			boolean isMatch = passwordEncoder.matches(userpwd, user.getUserPassword());
			if (!isMatch) {
				throw new DataDeliveryException(Define.SIGNIN_PWD_AGAIN, HttpStatus.BAD_REQUEST);
			}
		}

		if (principal.getSubscribing().equals("Y")) {
			if(principal.getOrderName().equals("basic")) {
				session.setAttribute("orderName", "basic");
			}

			if(principal.getOrderName().equals("premium")) {
				session.setAttribute("orderName", "premium");
			}
		} else {
			session.setAttribute("orderName", null);
		}
		System.out.println("OrderName : " + session.getAttribute("orderName"));

		// 세션 생성
		HttpSession session = request.getSession(true);
		session.setAttribute("principal", principal);

		return "redirect:/user/main";

	}

	/**
	 * 로그아웃 처리 - 로컬, 소셜
	 * 
	 * @return
	 */
	@GetMapping("/logout")
	public String logout(HttpServletResponse response, HttpServletRequest request, User user,
			PrincipalDTO principalDTO) {
		principalDTO = (PrincipalDTO) session.getAttribute("principal");
		session.invalidate();

//		Cookie[] userCookie = request.getCookies();
//		for (Cookie cookie : userCookie) {
//			cookie.setMaxAge(0);
//			response.addCookie(cookie);
//		}
		return "redirect:/user/main";
	}

	/**
	 * 로컬 회원가입
	 * 
	 * @param dto
	 * @param mFile
	 * @return
	 */
	public String signUpProc(SignUpDTO dto, @RequestParam("mFile") MultipartFile mFile) {
		userService.createUser(dto);
		return "redirect:/user/sign-up";
	}

	// 소셜 로그인 파트 시작 - 네이버, 카카오, 구글
	/**
	 * 네이버 소셜 로그인 로직 처리 요청
	 * 
	 * @param code
	 * @param state
	 * @return
	 */
	@GetMapping("/naver")
	public String getMethodName(@RequestParam(name = "code", required = false) String code,
			@RequestParam(name = "state", required = false) String state, Model model) {
		// Access Token 발급 요청
		RestTemplate naverRt1 = new RestTemplate();
		HttpHeaders header1 = new HttpHeaders();
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<>();
		params1.add("grant_type", naverGrantTypeIssue);
		params1.add("client_id", naverClientId);
		params1.add("client_secret", naverClientSecret);
		params1.add("code", code);
		params1.add("state", state);
		HttpEntity<MultiValueMap<String, String>> reqNaverToken = new HttpEntity<>(params1, header1);
		ResponseEntity<NaverToken> response = naverRt1.exchange(Define.NAVER_REQUEST_ACCESSTOKEN_URL, HttpMethod.POST,
				reqNaverToken, NaverToken.class);
		accessToken = response.getBody().getAccess_token();

		// Access Token으로 유저 정보 받아오기
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders header2 = new HttpHeaders();
		header2.add("Authorization", "Bearer " + response.getBody().getAccess_token());
		HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity<>(header2);
		ResponseEntity<NaverUserInfoDTO> response2 = rt2.exchange(Define.NAVER_REQUEST_USERINFO_URL, HttpMethod.POST,
				naverProfileRequest, NaverUserInfoDTO.class);
		NaverUserInfoDTO naverUserInfoDTO = response2.getBody();
		naverUserInfoDTO.genderType(naverUserInfoDTO.getResponse().getGender());

		SignUpDTO signUpDTO = SignUpDTO.builder().username(naverUserInfoDTO.getResponse().getName())
				.userId(naverUserInfoDTO.getResponse().getId()).userPassword(Define.SOCIAL_PASSWORD_NAVER)
				.userNickname(naverUserInfoDTO.getResponse().getNickname())
				.userEmail(naverUserInfoDTO.getResponse().getEmail())
				.userBirth(naverUserInfoDTO.getResponse().getBirthyear() + "-"
						+ naverUserInfoDTO
								.getResponse().getBirthday())
				.userGender(naverUserInfoDTO.getResponse().getGender())
				.userTel(naverUserInfoDTO.getResponse().getMobile()).userSocialType(Define.SOCIAL_TYPE_IS_NAVER)
//				.userOriginProfileImage(naverUserInfoDTO.getResponse().getProfile_image())
				.build();

		// 최초 소셜 사용자인지 판별
		PrincipalDTO principalDTO = userService.searchUserEmail(signUpDTO.getUserEmail());
		if (principalDTO == null) {
			userService.createUser(signUpDTO);
		}

		session.setAttribute("principal", principalDTO);

		return "redirect:/user/main";
	}

	/**
	 * 카카오 로그인 API
	 * 
	 * @param code
	 * @return
	 */
	@GetMapping("/kakao")
	public String getMethodName(@RequestParam(name = "code", required = false) String code, Model model) {
		// Access Token 발급 요청
		RestTemplate rt1 = new RestTemplate();
		HttpHeaders header1 = new HttpHeaders();
		header1.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", kakaoClientId);
		params.add("redirect_uri", kakaoRedirectUri);
		params.add("code", code);
		HttpEntity<MultiValueMap<String, String>> reqkakaoToken = new HttpEntity<>(params, header1);
		ResponseEntity<KakaoToken> response1 = rt1.exchange(Define.KAKAO_REQUEST_ACCESSTOKEN_URL, HttpMethod.POST,
				reqkakaoToken, KakaoToken.class);
		accessToken = response1.getBody().getAccess_token();

		// Access Token으로 유저 정보 받아오기
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + response1.getBody().getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		HttpEntity<MultiValueMap<String, String>> reqKakaoMessage = new HttpEntity<>(headers2);
		ResponseEntity<KakaoUserInfoDTO> response2 = rt2.exchange(Define.KAKAO_REQUEST_USERINFO_URL, HttpMethod.POST,
				reqKakaoMessage, KakaoUserInfoDTO.class);
		kakaoUserInfoDTO = response2.getBody();

		// 최초 소셜 사용자인지 판별
		PrincipalDTO principalDTO = userService.searchUserId(kakaoUserInfoDTO.getId());
		if (principalDTO == null) {
			return "user/addKakaoUserInfo";
		}

		session.setAttribute("principal", principalDTO);

		return "redirect:/user/main";
	}

	/**
	 * 카카오 로그인시 추가 정보 로직 처리
	 * 
	 * @param
	 * @param kakaoAddUserInfoDTO - 추가 정보: 이름, 이메일, 성별, 생일, 전화번호
	 * @param session
	 * @return
	 */
	@PostMapping("/addKakaoUserInfo")
	public String addKakaoUserInfo(KakaoAddUserInfoDTO kakaoAddUserInfoDTO, HttpSession session) {

		SignUpDTO signUpDTO = SignUpDTO.builder().username(kakaoAddUserInfoDTO.getUsername())
				.userId(kakaoUserInfoDTO.getId()).userPassword(Define.SOCIAL_PASSWORD_KAKAO)
				.userNickname(kakaoUserInfoDTO.getProperties().getNickname())
				.userEmail(kakaoAddUserInfoDTO.getUserEmail()).userBirth(kakaoAddUserInfoDTO.getUserBirth())
				.userGender(kakaoAddUserInfoDTO.getUserGender()).userTel(kakaoAddUserInfoDTO.getUserTel())
				.userSocialType(Define.SOCIAL_TYPE_IS_KAKAO)
//				.userOriginProfileImage(naverUserInfoDTO.getResponse().getProfile_image())
				.build();

		// 유효성 검사
		if (!ValidationUtil.isValidateName(kakaoAddUserInfoDTO.getUsername())) {
			throw new DataDeliveryException(Define.SIGNUP_NAME, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateEmail(kakaoAddUserInfoDTO.getUserEmail())) {
			throw new DataDeliveryException(Define.SIGNUP_EMAIL, HttpStatus.BAD_REQUEST);
		}
		if (kakaoAddUserInfoDTO.getUserBirth() == null || kakaoAddUserInfoDTO.getUserBirth().trim().isEmpty()) {
			throw new DataDeliveryException(Define.SIGNUP_BIRTH, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateTel(kakaoAddUserInfoDTO.getUserTel())) {
			throw new DataDeliveryException(Define.SIGNUP_TEL, HttpStatus.BAD_REQUEST);
		}

		userService.createUser(signUpDTO);
		PrincipalDTO principalDTO = userService.searchUserId(kakaoUserInfoDTO.getId());

		session.setAttribute("principal", principalDTO);

		return "redirect:/user/main";
	}

	/**
	 * 구글 로그인 API
	 * 
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/google")
	public String google(@RequestParam(name = "code") String code, HttpServletResponse response) throws IOException {
		// Access Token 발급 요청
		RestTemplate rt1 = new RestTemplate();
		HttpHeaders header1 = new HttpHeaders();
		MultiValueMap<String, String> params1 = new LinkedMultiValueMap<String, String>();
		params1.add("client_id", googleClientId);
		params1.add("client_secret", googleClientSecret);
		params1.add("code", code);
		params1.add("grant_type", googleGrantType);
		params1.add("redirect_uri", googleRedirectUri);
		HttpEntity<MultiValueMap<String, String>> reqgoogleMessage = new HttpEntity<>(params1, header1);
		ResponseEntity<GoogleTokenDTO> response1 = rt1.exchange(Define.GOOGLE_REQUEST_ACCESSTOKEN_URL, HttpMethod.POST,
				reqgoogleMessage, GoogleTokenDTO.class);
		GoogleTokenDTO dto = response1.getBody();

		// Access Token으로 유저 정보 받아오기
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + dto.getAccessToken());
		HttpEntity<MultiValueMap<String, String>> reqgoogleInfoMessage = new HttpEntity<>(headers2);
		ResponseEntity<GoogleUserInfoDTO> response2 = rt2.exchange(
				Define.GOOGLE_REQUEST_USERINFO_URL + dto.getAccessToken(), HttpMethod.GET, reqgoogleInfoMessage,
				GoogleUserInfoDTO.class);
		googleUserInfoDTO = response2.getBody();

		// 최초 소셜 사용자인지 판별
		PrincipalDTO principalDTO = userService.searchUserEmail(googleUserInfoDTO.getEmail());
		if (principalDTO == null) {
			PrintWriter out = response.getWriter();
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			out.println("<script>alert('추가 정보를 입력해주세요.')</script>");
			out.flush();
			return "user/addGoogleInfo";
		} else {
			session.setAttribute("principal", principalDTO);
			return "redirect:/user/main";
		}
	}

	/**
	 * 구글 로그인시 추가 정보 로직 처리
	 * 
	 * @param info    - 추가 정보: 이메일, 성별, 생일, 전화번호, 별명
	 * @param session
	 * @return
	 */
	@PostMapping("/addGoogleInfo")
	public String addInfo(AddGoogleInfoDTO info, HttpSession session) {
		SignUpDTO signUpDTO = SignUpDTO.builder().userId(googleUserInfoDTO.getId())
				.userEmail(googleUserInfoDTO.getEmail()).username(googleUserInfoDTO.getName())
				.userPassword(Define.SOCIAL_PASSWORD_GOOGLE).userGender(info.getUserGender())
				.userBirth(info.getUserBirth()).userTel(info.getUserTel()).userNickname(info.getUserNickname())
				.userSocialType(Define.SOCIAL_TYPE_IS_GOOGLE).build();

		// 유효성 검사
		if (info.getUserBirth() == null || info.getUserBirth().trim().isEmpty()) {
			throw new DataDeliveryException(Define.SIGNUP_BIRTH, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidateTel(info.getUserTel())) {
			throw new DataDeliveryException(Define.SIGNUP_TEL, HttpStatus.BAD_REQUEST);
		}

		userService.createUser(signUpDTO);
		PrincipalDTO principalDTO = userService.searchUserEmail(signUpDTO.getUserEmail());

		session.setAttribute("principal", principalDTO);

		return "redirect:/user/main";
	}

	/**
	 * 유저 마이페이지 요청
	 * 
	 * @return
	 */
	@GetMapping("/my-info")
	public String getUserInfoPage() {
		return "user/myPage/myInfo";
	}
	
	/**
	 * 유저 마이페이지 > 구독 내역 페이지 요청
	 * @return
	 */
	@GetMapping("/my-subscribe")
	public String getMySubscribe() {
		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		if(principalDTO == null) {
			return "redirect:user/sign-in";
		}
		
		int userPk = principalDTO.getId();
		
		Subscribing subscribing = paymentService.checkUserPayInfo(userPk);
		
		if(subscribing != null) {
			session.setAttribute("subscribing", subscribing);
		}else {
			session.setAttribute("subscribing", null);
		}
		
		return "user/myPage/mySubscribe";
	}
	
	/**
	 * 유저 마이페이지 > 포트폴리오 페이지 요청
	 * @return
	 */
	@GetMapping("/my-portfolio")
	public String getUserPortfolioPage() {
		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		if(principalDTO == null) {
			return "redirect:user/sign-in";
		}
		int userPk = principalDTO.getId();

		Portfolio portfolio = portfolioService.getMyPortfolio(userPk);
		
		if(portfolio != null) {
			session.setAttribute("portfolio", portfolio);
		}else {
			session.setAttribute("portfolio", null);
		}
		
		return "user/myPage/myPortfolio";
	}
	
	
	/**
	 * 구독해지 사유 받아오기
	 * @return
	 */
	@PostMapping("/termination")
	public String getMethodName(@RequestParam(value = "cancelReason", required = false) String cancelReason,
			@RequestParam(value = "userPk", required = false) Integer userPk) {
		paymentService.termination(cancelReason,userPk);
		paymentService.stopSubscribe(userPk);
		return "redirect:/user/my-subscribe";
	}
	
	/**
	 * 회원탈퇴 페이지 http://alocalhost:8080/user/withdraw
	 * 
	 * @param
	 * @return
	 */
	@GetMapping("/withdraw")
	public String withdrawPage() {
		return "user/withdraw";
	}

	/**
	 * 회원탈퇴 로직 처리
	 * 
	 * @param withdrawDTO - 탈퇴 사유
	 * @param
	 */
	@PostMapping("/withdraw")
	public String withdrawProc(WithdrawDTO withdrawDTO, HttpSession session) {
		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		if(principalDTO == null) {
			return "redirect:user/sign-in";
		}
		userService.withdrawUser(principalDTO, withdrawDTO);
		paymentService.stopSubscribe(principalDTO.getId());
		session.invalidate();

		return "redirect:/user/main";
	}

	/**
	 * 비밀번호 찾기 화면
	 * @return
	 */
	@GetMapping("/findPassword")
	public String findPasswordPage() {
		return "user/findPasswordByEmail";
	}

	/**
	 * 이메일로 비밀번호 찾기 화면
	 * @return
	 */
	@GetMapping("/findPasswordByEmail")
	public String findPasswordByEmailPage() {
		return "user/findPasswordByEmail";
	}
	
	/**
	 * 이메일로 아이디 찾기 화면
	 * @return
	 */
	@GetMapping("/findUserIdByEmail")
	public String findUserIdByEmailPage() {
		return "user/findUserIdByEmail";
	}

	// TODO 예외 처리 클래스 만들고 조건문에 throw new 해주기
	@PostMapping("/changePassword")
	public String changePasswordPage(ChangePasswordDTO changePasswordDTO) {
		if (!changePasswordDTO.getNewPassword().equals(changePasswordDTO.getCheckPassword())) {
			System.out.println("일치하지 않습니다.");
			// throw new Exception();
		}

		userService.changPassword(changePasswordDTO.getNewPassword(), changePasswordDTO.getUserId());
		// 변경 완료 알림 alert 후, 창 닫기
		return "user/signIn";

	}

	@GetMapping("/recommendListPage")
	public String showRecommendedCompanies() {
		return "user/viewRecommendCompanies";
	}

	@GetMapping("/getRecommend")
	@ResponseBody
	public List<RecommendCompanies> getRecommendedCompanies(
			@RequestParam(value = "dateOption", required = false) String dateOption,
			@RequestParam(value = "qualificationOption", required = false) String qualificationOption,
			@RequestParam(value = "similarityOption", required = false) String similarityOption
	) {

		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		List<RecommendCompanies> recommendList = new ArrayList<>(); // 초기화 문제 해결
		int limit = 0;
		final double SIXTY_PERCENT = 0.6;
		final double SEVENTY_PERCENT = 0.7;

		// 기본값으로 모든 데이터를 가져오도록 설정
		if (principalDTO.getSubscribing().equals("N")) {
			limit = 100; // 미 구독자에겐 3개의 박스 제공
		} else if (principalDTO.getSubscribing().equals("Y")) {
			if (principalDTO.getOrderName().equals("basic")) {
				limit = 100; // basic 구독자에겐 10개의 박스 제공
			} else if (principalDTO.getOrderName().equals("premium")) {
				System.out.println("Here !");
				limit = 500; // premium 구독자는 제한 없음
			}
		}
		System.out.println("Limit info : " + limit);
		// 서비스에서 추천 목록 가져오기
		List<RecommendCompanies> normalRecommendList
				= jobNoticeService.getRecommendCompanies(principalDTO.getId(), limit, dateOption, similarityOption, qualificationOption);

		// 모든 추천 목록을 순회
		for (RecommendCompanies recommendCompanies : normalRecommendList) {
			// 구독이 "N"이고 similarity가 특정 수치 이상인 경우 정보 제한
			if (principalDTO.getSubscribing().equals("N") && recommendCompanies.getSimilarity() > SIXTY_PERCENT) {
				RecommendCompanies overRecommend = RecommendCompanies.builder()
						.title(recommendCompanies.getTitle())
						.companyName(null) // 제한된 정보로 설정
						.jobUrl(null)
						.site(null)
						.userId(recommendCompanies.getUserId())
						.similarity(recommendCompanies.getSimilarity()) // similarity는 그대로 표시
						.recommendedDate(recommendCompanies.getRecommendedDate())
						.boardId(recommendCompanies.getBoardId())
						.build();
				recommendList.add(overRecommend);
			}
			// 구독이 "Y"이고 basic일 때 similarity가 특정 수치 이상인 경우 정보 제한
			else if (principalDTO.getSubscribing().equals("Y") && principalDTO.getOrderName().equals("basic")
					&& recommendCompanies.getSimilarity() > SEVENTY_PERCENT) {
				RecommendCompanies overRecommend = RecommendCompanies.builder()
						.title(recommendCompanies.getTitle())
						.companyName(null) // 제한된 정보로 설정
						.jobUrl(null)
						.site(null)
						.userId(recommendCompanies.getUserId())
						.similarity(recommendCompanies.getSimilarity()) // similarity는 그대로 표시
						.recommendedDate(recommendCompanies.getRecommendedDate())
						.boardId(recommendCompanies.getBoardId())
						.build();
				recommendList.add(overRecommend);
			}
			// 나머지 경우에는 모든 정보를 그대로 표시
			else {
				recommendList.add(recommendCompanies);
			}
		}
		System.out.println("RecommendList : " + recommendList);
		return recommendList; // 최종 결과 반환
	}

	
	@GetMapping("/cleanup")
	@ResponseBody
    public String cleanupOldWithdrawals() {
        userService.deleteOldWithdraw();
        return "Cleanup initiated.";
    }

	@GetMapping("/updateUserInfo")
	public String updateUserInfopage(Model model) {
		PrincipalDTO principalDTO = (PrincipalDTO)session.getAttribute("principal");
		User user = userService.searchById(principalDTO.getId());
		model.addAttribute("user", user);
		return "user/myPage/updateUserInfo";
	}

	@PostMapping("/updateUserInfo")
	public String updateUserInfoProc(UpdateUserDTO updateUserDTO) {
		System.out.println("Update User DTO : " + updateUserDTO.toString());
		PrincipalDTO principalDTO = (PrincipalDTO)session.getAttribute("principal");
		updateUserDTO.setId(principalDTO.getId());
		userService.updateUserInfo(updateUserDTO);
		return "/user/myPage/myInfo";
	}

	@GetMapping("/userSkillPage")
	public String getSkillPage(Model model) {
		PrincipalDTO principalDTO = (PrincipalDTO)session.getAttribute("principal");
		model.addAttribute("user", principalDTO);
		return "/admin/mongoData";
	}

	@GetMapping("/mySkillPage")
	public String getMySkillPage(Model model) {
		PrincipalDTO principalDTO = (PrincipalDTO)session.getAttribute("principal");
		List<Map<String, Object>> userSkillList = userService.getUserSkillList(principalDTO.getId());

		System.out.println("User Skill List1 :  " + userSkillList);
		System.out.println("User Skill List2 :  " + userSkillList);
		model.addAttribute("userSkillList", userSkillList);

		return "/user/myPage/mySkill";

	}

}

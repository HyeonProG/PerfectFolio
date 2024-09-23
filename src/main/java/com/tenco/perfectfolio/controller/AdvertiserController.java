package com.tenco.perfectfolio.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import javax.imageio.ImageIO;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tenco.perfectfolio.dto.advertiser.AdvertiserApplicationDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserRequestingRefundDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserSignInDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserSignUpDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserWithdrawDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.repository.model.advertiser.Advertiser;
import com.tenco.perfectfolio.schedule.AdvertiserScheduler;
import com.tenco.perfectfolio.service.AdvertiserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/advertiser")
@RequiredArgsConstructor
public class AdvertiserController {

	@Autowired
	private final AdvertiserService advertiserService;

	@Autowired
	private final AdvertiserScheduler advertiserScheduler;

	private final Map<String, Integer> imageClickCounts = new ConcurrentHashMap<>();

	@Autowired
	private final HttpSession session;

	@Autowired
	private ResourceLoader resourceLoader;

	/**
	 * 중복 검사
	 * 
	 * @param userId
	 * @return
	 */
	@GetMapping("/checkId")
	public ResponseEntity<Map<String, String>> checkDuplicate(@RequestParam("userId") String userId) {
		Map<String, String> response = new HashMap<>();
		System.out.println("userId:" + userId);
		int result = advertiserService.checkId(userId);
		System.out.println("result:" + result);
		if (result != 0) {
			System.out.println("중복된 아이디");
			response.put("message", "중복된 ID는 사용할 수 없습니다.");
			return ResponseEntity.badRequest().body(response);
		}

		System.out.println("사용 가능");
		response.put("message", "사용 가능한 ID입니다.");
		return ResponseEntity.ok(response);
	}

	/**
	 * 회원가입 페이지 요청
	 * 
	 * @return advertiser/signUp.jsp
	 */
	@GetMapping("/sign-up")
	public String signUpPage() {
		return "advertiser/signUp";
	}

	/**
	 * 회원가입 로직 처리
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-up")
	public String signUpProc(AdvertiserSignUpDTO dto) {
		// 유효성 검사
		if (dto.getUserId() == null || dto.getUsername().isEmpty()) {
			throw new DataDeliveryException("아이디를 입력해주세요.", HttpStatus.BAD_REQUEST);
		}
		if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
			throw new DataDeliveryException("비밀번호를 입력해주세요.", HttpStatus.BAD_REQUEST);
		}

		advertiserService.createAdvertiser(dto);

		return "redirect:/user/sign-in";
	}

	/**
	 * 로그인 로직 처리
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/sign-in")
	public String signInProc(AdvertiserSignInDTO dto) {

		// 유효성 검사
		if (dto.getUserId() == null || dto.getUserId().isEmpty()) {
			throw new DataDeliveryException("아이디를 입력하세요.", HttpStatus.BAD_REQUEST);
		}
		if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
			throw new DataDeliveryException("비밀번호를 입력하세요.", HttpStatus.BAD_REQUEST);
		}

		Advertiser advertiser = advertiserService.readAdvertiser(dto);

		session.setAttribute("advertiser", advertiser);

		return "redirect:/user/main";
	}

	/**
	 * 로그아웃
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/user/main";
	}

	/**
	 * 광고 신청 페이지
	 * 
	 * @return advertiser/application.jsp
	 */
	@GetMapping("/application")
	public String adApplicationPage(HttpSession session, Model model) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		if (advertiser != null) {
			model.addAttribute("userId", advertiser.getId());
			System.out.println(advertiser.toString());
		} else {
			// 사용자가 로그인되지 않은 경우 처리
			return "redirect:/user/sign-in";
		}
		return "advertiser/application";
	}

	/**
	 * 광고 신청 로직 처리
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/application")
	@ResponseBody
	public ResponseEntity<?> adApplicationProc(AdvertiserApplicationDTO dto) {
		// 유효성 검사
		if (dto.getTitle() == null || dto.getTitle().isEmpty()) {
			return ResponseEntity.badRequest().body("제목을 입력해주세요.");
		}
		if (dto.getContent() == null || dto.getContent().isEmpty()) {
			return ResponseEntity.badRequest().body("내용을 입력해주세요.");
		}
		if (dto.getSite() == null || dto.getSite().isEmpty()) {
			return ResponseEntity.badRequest().body("주소를 입력해주세요.");
		}
		if (dto.getMFile() == null || dto.getMFile().isEmpty()) {
			return ResponseEntity.badRequest().body("파일을 업로드 해주세요.");
		}

		// 광고 신청 처리
		advertiserService.createAdApplication(dto);

		// 성공 메시지 응답
		return ResponseEntity.ok("신청이 완료되었습니다.");
	}

	/**
	 * 결제 페이지 요청
	 * 
	 * @return
	 */
	@GetMapping("/payment")
	public String paymentPage(HttpSession session, Model model) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		if (advertiser != null) {
			model.addAttribute("username", advertiser.getUsername());
			model.addAttribute("userId", advertiser.getId());
			System.out.println(advertiser.toString());
		} else {
			// 사용자가 로그인되지 않은 경우 처리
			return "redirect:/user/sign-in";
		}

		return "advertiser/payment";
	}

	/**
	 * 결제 성공 처리 및 잔액 업데이트
	 */
	@GetMapping("/success")
	public String paymentResult(Model model, @RequestParam("orderId") String orderId,
			@RequestParam("amount") Integer amount, @RequestParam("paymentKey") String paymentKey) throws Exception {

		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		int userId = advertiser.getId();

		System.out.println("userID : " + userId);

		try {
			// 결제 확인 서비스 호출
			JSONObject jsonObject = advertiserService.confirmPayment(orderId, amount, paymentKey, userId);
			model.addAttribute("isSuccess", true);
			model.addAttribute("responseStr", jsonObject.toJSONString());

			// 유저의 balance 업데이트 로직
			if (advertiser != null) {
				advertiserService.updateBalance(advertiser.getId(), amount);
			}

		} catch (Exception e) {
			model.addAttribute("isSuccess", false);
			model.addAttribute("message", e.getMessage());
		}

		return "advertiser/success"; // 결제 성공 페이지
	}

	/**
	 * 결제 실패 처리
	 */
	@GetMapping("/fail")
	public String paymentFail(Model model, @RequestParam(value = "message") String message,
			@RequestParam(value = "code") String code) {

		model.addAttribute("isSuccess", false);
		model.addAttribute("code", code);
		model.addAttribute("message", message);

		return "advertiser/fail"; // 결제 실패 페이지
	}

	/**
	 * 환불 신청 페이지 최초 요청
	 * 
	 * @return
	 */
	@GetMapping("/refund")
	public String paymentHistoryPage() {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		if (advertiser != null) {
			return "advertiser/refund";
		} else {
			// 관리자가 로그인되지 않은 경우 처리
			return "redirect:/admin/sign-in";
		}
	}

	/**
	 * 환불 신청 페이지 페이징
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/refundList")
	public ResponseEntity<Map<String, Object>> paymentHistoryPage(HttpSession session, Model model,
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size) {

		int totalCount = 0;
		int totalPages = 0;
		Map<String, Object> response = new HashMap<>();

//		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
//		if (advertiser != null) {
//			model.addAttribute("username", advertiser.getUsername());
//			model.addAttribute("userId", advertiser.getId());
//			model.addAttribute("balance", advertiser.getBalance());
//			System.out.println(advertiser.toString());
//
////			List<AdvertiserPaymentDTO> paymentHistory = advertiserService.readPaymentById(advertiser.getId());
//			model.addAttribute("refundList", paymentHistory);
//
//		} else {
//			// 사용자가 로그인되지 않은 경우 처리
////			return "redirect:/user/sign-in";
//		}

//		List<AdvertiserPaymentDTO> paymentHistory = advertiserService.readAllPaymentList(page, size);
//		totalCount = advertiserService.getPayListCounts();
		List<AdvertiserRequestingRefundDTO> paymentHistory = advertiserService.readAllRequestList(page, size);
		totalCount = advertiserService.getRequestListCounts();

		System.out.println("리스트 : " + paymentHistory);

		totalPages = (int) Math.ceil((double) totalCount / size);

		response.put("refundList", paymentHistory);
		response.put("totalCount", totalCount);
		response.put("totalPages", totalPages);
		response.put("currentPage", page);
		response.put("pageSize", size);

		return ResponseEntity.ok(response);
	}

	/**
	 * 환불 신청 로직
	 * 
	 * @param paymentKey
	 * @param cancelAmount
	 * @param cancelReason
	 * @param orderId
	 * @return
	 */
	@PostMapping("/refund")
	public String refundProc(@RequestParam("paymentKey") String paymentKey,
			@RequestParam("cancelAmount") Integer cancelAmount, @RequestParam("cancelReason") String cancelReason) {

		// 세션에서 로그인한 사용자의 정보를 가져옴
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		if (advertiser == null) {
			return "redirect:/user/sign-in"; // 로그인하지 않았을 경우 로그인 페이지로 리다이렉트
		}
		int userId = advertiser.getId();

		try {
			// 환불 처리 서비스 호출
			String response = advertiserService.cancelAdvertiserPayment(userId, paymentKey, cancelAmount, cancelReason);
			System.out.println("--------------------------------------");
			System.out.println("response : " + response);
			System.out.println("--------------------------------------");
		} catch (Exception e) {
			return "Refund failed: " + e.getMessage();
		}

		// 환불 처리 후 성공 페이지로 리다이렉트
		return "redirect:/advertiser/payment-history";
	}

	/**
	 * 광고 신청 처리 페이지
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/review")
	public String pendingApplicationPage(HttpSession session, Model model) {

		Admin admin = (Admin) session.getAttribute("admin");

		if (admin != null) {
			List<AdvertiserApplicationDTO> pendingApplications = advertiserService.readAllPendingApplications();
			model.addAttribute("applicationsList", pendingApplications);

		} else {
			return "redirect:/admin/sign-in";
		}
		return "advertiser/review"; // JSP 페이지
	}

	/**
	 * 관리자 광고 신청 목록 AJAX 요청을 처리할 엔드포인트
	 * 
	 * @param page
	 * @param size
	 * @return
	 */
	@GetMapping("/review/list")
	@ResponseBody
	public Map<String, Object> pendingApplicationPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size) {

		// 광고 신청 목록을 페이지별로 조회
		List<AdvertiserApplicationDTO> pendingApplications = advertiserService.readPendingApplications(page, size);
		int totalApplications = advertiserService.countPendingApplications(); // 전체 대기 중인 광고 신청 수
		int totalPages = (int) Math.ceil((double) totalApplications / size);

		// 응답 데이터
		Map<String, Object> response = new HashMap<>();
		response.put("applicationsList", pendingApplications);
		response.put("totalCount", totalApplications);
		response.put("currentPage", page);
		response.put("pageSize", size);
		response.put("totalPages", totalPages);

		return response;
	}

	/**
	 * 광고 승인 신청 상세 페이지
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/review/detail/{id}")
	public String pendingApplicationDetailPage(@PathVariable(name = "id") Integer id, Model model) {
		AdvertiserApplicationDTO application = advertiserService.readPendingApplicationDetail(id);
		model.addAttribute("application", application);

		// 이미지 파일 경로 (application.getUploadFileName()은 실제 저장된 파일 이름)
		String saveDirectory = null;
		try {
			saveDirectory = System.getProperty("user.dir") + "/src/main/resources/static/images/ad/";
			System.out.println("SAVEDIRECTORY" + saveDirectory);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String imagePath = saveDirectory + application.getUploadFileName();

		System.out.println(imagePath);

		// 이미지 파일의 폭과 높이 계산
		try {
			File imgFile = new File(imagePath);
			System.out.println("imgFile : " + imgFile);
			BufferedImage image = ImageIO.read(imgFile);
			int width = image.getWidth();
			int height = image.getHeight();
			model.addAttribute("imageWidth", width);
			model.addAttribute("imageHeight", height);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("imageError", "이미지를 불러오는 중 오류가 발생했습니다.");
		}

		// 이미지 경로를 모델에 추가 (이미지 표시용)
		model.addAttribute("imagePath", "/images//ad/" + application.getUploadFileName());

		return "advertiser/detail";
	}

	/**
	 * 광고 신청 승인 로직
	 * 
	 * @param id
	 * @return
	 */
	@PostMapping("/approve")
	public String approveApplication(@RequestParam("id") Integer id) {
		try {
			advertiserService.updateApplicationState(id, "승인");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/advertiser/review";
	}

	/**
	 * 광고 신청 거절 로직
	 * 
	 * @param id
	 * @return
	 */
	@PostMapping("/reject")
	public String rejectApplication(@RequestParam("id") Integer id) {
		try {
			advertiserService.updateApplicationState(id, "거절");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/advertiser/review";
	}

	/**
	 * 내정보 페이지
	 * 
	 * @return
	 */
	@GetMapping("/my-info")
	public String myInfoPage(HttpSession session, Model model) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");

		if (advertiser != null) {
			model.addAttribute("advertiser", advertiser);
			model.addAttribute("userId", advertiser.getId());
			model.addAttribute("balance", advertiser.getBalance());
		} else {
			return "redirect:/user/sign-in";
		}

		return "/advertiser/myInfo";
	}

	/**
	 * 광고주 광고 신청 목록
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/application-list")
	public String applicationListPage(HttpSession session, Model model) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");

		if (advertiser != null) {
			List<AdvertiserApplicationDTO> pendingApplications = advertiserService
					.readAllPendingApplicationsById(advertiser.getId());
			model.addAttribute("applicationsList", pendingApplications);
			model.addAttribute("userId", advertiser.getId());
		} else {
			return "redirect:/user/sign-in";
		}
		return "/advertiser/applicationList";
	}

	/**
	 * 광고주 광고 신청 목록 AJAX 요청을 처리할 엔드포인트
	 * 
	 * @param page
	 * @param size
	 * @param session
	 * @return
	 */
	@GetMapping("/application-list/data")
	@ResponseBody
	public Map<String, Object> fetchApplicationListPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int size, HttpSession session) {

		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");

		// 광고 신청 목록을 페이지별로 조회
		List<AdvertiserApplicationDTO> pendingApplications = advertiserService
				.readAllPendingApplicationsById(advertiser.getId(), page, size);
		int totalApplications = advertiserService.countAllPendingApplicationsById(advertiser.getId());
		int totalPages = (int) Math.ceil((double) totalApplications / size);

		// 응답 데이터
		Map<String, Object> response = new HashMap<>();
		response.put("applicationsList", pendingApplications);
		response.put("totalCount", totalApplications);
		response.put("currentPage", page);
		response.put("pageSize", size);
		response.put("totalPages", totalPages);

		return response;
	}

	/**
	 * 광고 신청 취소
	 * 
	 * @param id
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("/application-list/delete/{id}")
	public String deleteApplicationProc(@PathVariable("id") Integer id) {

		try {
			// 광고 신청과 연관된 파일명을 가져옴
			String imageFileName = advertiserService.cancelAdApplication(id);

			if (imageFileName != null && !imageFileName.isEmpty()) {
				// 이미지 파일이 저장된 경로
				String directoryPath = System.getProperty("user.dir") + "/src/main/resources/static/images/ad/";
				Path filePath = Paths.get(directoryPath, imageFileName);

				// 파일 삭제
				try {
					Files.deleteIfExists(filePath);
					System.out.println("이미지 삭제 완료 : " + imageFileName);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("이미지 삭제 실패 : " + imageFileName);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/advertiser/application-list";
	}

	/**
	 * 광고주 사용 중인 광고 목록 페이지
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/active-list")
	public String activeAdvertiserPage(HttpSession session, Model model) {
	    Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");

	    if (advertiser != null) {
	        model.addAttribute("userId", advertiser.getId());
	    } else {
	        return "redirect:/user/sign-in";
	    }
	    return "/advertiser/activeList";
	}

	/**
	 * 광고주 사용 중인 광고 목록 AJAX 요청을 처리할 엔드포인트
	 * 
	 * @param page
	 * @param size
	 * @param session
	 * @return
	 */
	@GetMapping("/active-list/data")
	@ResponseBody
	public Map<String, Object> fetchActiveAdListPage(
	        @RequestParam(name = "page", defaultValue = "1") int page,
	        @RequestParam(name = "size", defaultValue = "5") int size,
	        HttpSession session) {

	    Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");


	    // 광고 신청 목록을 페이지별로 조회
	    List<AdvertiserApplicationDTO> activeAdList = advertiserService.findUsingApplicationsById(advertiser.getId(), page, size);
	    int totalApplications = advertiserService.countUsingApplicationsById(advertiser.getId());
	    int totalPages = (int) Math.ceil((double) totalApplications / size);

	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("activeAdList", activeAdList);
	    response.put("totalCount", totalApplications);
	    response.put("currentPage", page);
	    response.put("pageSize", size);
	    response.put("totalPages", totalPages);

	    return response;
	}


	/**
	 * 광고주 마이페이지 광고 상태 업데이트
	 * 
	 * @param id
	 * @param state
	 * @return
	 */
	@PostMapping("/update-ad")
	public String updateUsingAdProc(@RequestParam("id") Integer id, @RequestParam("state") String state) {
		try {
			advertiserService.updateUsingApplication(id, state);
			System.out.println("id : " + id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/advertiser/active-list";
	}

	/**
	 * 내 잔액 실시간 확인
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/get-balance")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getBalance(HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		try {
			Advertiser advertiser = (Advertiser) session.getAttribute("advertiser"); // 세션에서 사용자 ID 가져오기
			System.out.println("userID : " + advertiser.getId());
			if (advertiser.getId() == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build(); // 사용자 ID가 없는 경우
			}
			int balance = advertiserService.getBalance(advertiser.getId()); // 서비스에서 잔액 조회
			response.put("balance", balance);
			System.out.println("balance : " + balance);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	/**
	 * 광고주 마이페이지 > 환불 요청 페이지 요청
	 * 
	 * @return
	 */
	@GetMapping("/requesting-refund")
	public String getMethodName(@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size, HttpServletRequest request) {

		// 처리 대기중인 리스트만
		List<AdvertiserRequestingRefundDTO> requestingList = advertiserService.readRequestList(page, size);

		// 처리 완료된 리스트만
		List<AdvertiserRequestingRefundDTO> requestingList2 = advertiserService.readDoneRequestList(page, size);

		if (requestingList != null) {
			request.setAttribute("requestingList", requestingList);
		} else {
			request.setAttribute("requestingList", null);
		}

		if (requestingList != null) {
			request.setAttribute("doneList", requestingList2);
		} else {
			request.setAttribute("doneList", null);
		}

		return "advertiser/requestingRefund";
	}

	/**
	 * 광고주 마이페이지 > 환불 요청 로직 처리
	 * 
	 * @return
	 */
	@PostMapping("/requesting-refund")
	public String postMethodName(AdvertiserRequestingRefundDTO dto) {
		PrincipalDTO principalDTO = (PrincipalDTO)session.getAttribute("principal");
		int userId = principalDTO.getId();
		dto.setUserId(userId);

		advertiserService.createRequestRefund(dto);
		return "redirect:/advertiser/requesting-refund";
	}

	/**
	 * 광고주 환불 요청 관리자 승인, 반려 처리
	 * 
	 * @param entity
	 * @return
	 */
	@PostMapping("/treatment")
	public String postMethodName(@RequestParam(name = "treatment") String treatment,
			@RequestParam(name = "id") Integer id, @RequestParam(name = "reject", required = false) String reject) {
		System.out.println("치즈 : " + treatment + id + reject);
		advertiserService.treatment(treatment, id, reject);
		return "redirect:/advertiser/refundList";
	}

	/**
	 * 랜덤 이미지 가져오기
	 * 
	 * @return
	 */
	@GetMapping("/random-image")
	public ResponseEntity<Map<String, Object>> getRandomImage() {
		// 승인된 광고 신청서 목록을 데이터베이스에서 가져옵니다.
		List<AdvertiserApplicationDTO> approvedApplications = advertiserService.readApproveApplications();

		// 승인된 광고 신청서에서 이미지 파일 이름과 site 값을 수집합니다.
		List<AdvertiserApplicationDTO> filteredApplications = approvedApplications.stream().filter(app -> {
			File imgFile = new File(System.getProperty("user.dir") + "/src/main/resources/static/images/ad/" + app.getUploadFileName());
			System.out.println("RANDOMFILEasdfsaf : " + imgFile);
			return imgFile.exists();
		}).collect(Collectors.toList());

		if (filteredApplications.isEmpty()) {
			return ResponseEntity.notFound().build();
		}

		// 랜덤으로 파일 선택
		AdvertiserApplicationDTO selectedApplication = filteredApplications
				.get((int) (Math.random() * filteredApplications.size()));

		File randomFile = new File(System.getProperty("user.dir") + "/src/main/resources/static/images/ad/" + selectedApplication.getUploadFileName());
		System.out.println("RANDOMFILE : " + randomFile);

		// 광고주의 금액 차감 요청을 메모리에 저장 (100원 차감)
		advertiserScheduler.addDeduction(selectedApplication.getUserId(), -100);

		// 이미지 노출 횟수 기록 (해당 이미지 파일명으로 노출 횟수를 관리)
		advertiserScheduler.addImageViewCount(selectedApplication.getUploadFileName());

		// 응답 데이터 준비
		Map<String, Object> response = new HashMap<>();
		response.put("imageUrl", "/images//ad/" + selectedApplication.getUploadFileName());
		response.put("site", selectedApplication.getSite());
		response.put("uploadFileName", randomFile);

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
	}

	/**
	 * 광고 클릭시 카운트 증가
	 * 
	 * @param request
	 * @return
	 */
	@PostMapping("/increment-click")
	@ResponseBody
	public ResponseEntity<String> incrementClickCount(@RequestBody Map<String, String> request) {
		String imageUrl = request.get("imageUrl");

		imageUrl = imageUrl.replaceFirst("/images//ad/", "");
		try {
			int temp = advertiserService.incrementClickCount(imageUrl, 1); // 클릭할 때마다 1 증가
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	/**
	 * 광고주 회원 탈퇴 페이지
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("/withdraw")
	public String withdrawPage(HttpSession session, Model model) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");

		if (advertiser != null) {
			model.addAttribute("id", advertiser.getId());
			model.addAttribute("userId", advertiser.getUserId());
		} else {
			return "redirect:/user/sign-in";
		}
		return "/advertiser/withdraw";
	}

	/**
	 * 광고주 회원 탈퇴 로직
	 * 
	 * @param withdrawDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/withdraw")
	public String withdrawProc(AdvertiserWithdrawDTO withdrawDTO, HttpSession session) {
		Advertiser advertiser = (Advertiser) session.getAttribute("advertiser");
		advertiserService.withdrawAdvertsier(advertiser, withdrawDTO);
		session.invalidate();

		return "redirect:/user/main";
	}

	/**
	 * 광고 뷰 카운트 리턴
	 * 
	 * @return
	 */
	@GetMapping("view-count")
	@ResponseBody
	public Integer countAllViewCount() {
		System.out.println(advertiserService.countAllViewCount());
		return advertiserService.countAllViewCount();
	}

	/**
	 * 광고 클릭 카운트 리턴
	 * 
	 * @return
	 */
	@GetMapping("click-count")
	@ResponseBody
	public Integer countAllClickCount() {
		System.out.println(advertiserService.countAllClickCount());
		return advertiserService.countAllClickCount();
	}

	/**
	 * 전체 광고주 결제 리턴
	 * 
	 * @return
	 */
	@GetMapping("payment-count")
	@ResponseBody
	public Integer countAllAdPayment() {
		System.out.println(advertiserService.countAllAdPayment());
		return advertiserService.countAllAdPayment();
	}

	/**
	 * 광고주 전체 환불 리턴
	 * 
	 * @return
	 */
	@GetMapping("refund-count")
	@ResponseBody
	public Integer countAllAdRefundPayment() {
		System.out.println(advertiserService.countAllAdRefundPayment());
		return advertiserService.countAllAdRefundPayment();
	}
	
	/**
	 * 광고주 전체 환불 금액 리턴
	 * @return
	 */
	@GetMapping("ad-refund-amount")
	@ResponseBody
	public Integer countAllAdRefundAmount() {
		System.out.println(advertiserService.countAllAdRefundAmount());
		return advertiserService.countAllAdRefundAmount();
	}

}

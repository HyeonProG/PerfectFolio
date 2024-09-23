package com.tenco.perfectfolio.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.dto.payment.PaymentDTO;
import com.tenco.perfectfolio.dto.payment.PaymentListDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.repository.model.payment.Refund;
import com.tenco.perfectfolio.service.PaymentService;
import com.tenco.perfectfolio.utils.Define;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/pay")
public class PaymentController {

	@Autowired
	private HttpSession session;
	@Autowired
	private PaymentService paymentService;
	private PaymentDTO paymentDTO;

	/**
	 * 결제 페이지 요청
	 *
	 * 주소 설계 : https://localhost:8080/pay/subscribe
	 *
	 * @return payment/payment.jsp
	 */
	@GetMapping("/subscribe")
	public String paymentPage() {
//		if (session.getAttribute("principal") == null) {
//			throw new DataDeliveryException(Define.ENTER_YOUR_LOGIN, HttpStatus.BAD_REQUEST);
//		}
		return "payment/payment";
	}

	/**
	 * 베이직 결제 로직 처리
	 *
	 * @param authKey
	 * @param customerKey
	 * @param model
	 * @return
	 */
	@GetMapping("/success")
	public String success(@RequestParam("authKey") String authKey, @RequestParam("customerKey") String customerKey,
			Model model) {

		// 권한 확인
		if (session.getAttribute("principal") == null) {
			throw new DataDeliveryException(Define.NOT_AN_AUTHENTICATED_USER, HttpStatus.BAD_REQUEST);
		}
		// 구독 진행중인지 확인
		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		int userPk = principalDTO.getId();
		int duplication = paymentService.checkDuplication(userPk);

		if (duplication == 0) {
			try {
				// 주문 ID 생성
				String orderId = UUID.randomUUID().toString();
				String orderName = "basic";
				int amount = 5900;

				// 빌링키 발급과 자동 결제 실행
				String response = paymentService.authorizeBillingAndAutoPayment(authKey, customerKey, orderId,
						orderName, amount, userPk); // 금액은 실제 금액으로 대체

				return "payment/success";

			} catch (Exception e) {
				model.addAttribute("message", e.getMessage());
				throw new DataDeliveryException(Define.FAILED_PAYMENT, HttpStatus.BAD_REQUEST);
//				return "redirect:/pay/fail";
			}

		} else {
			throw new DataDeliveryException(Define.FAILED_SUBSCRIBE, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 프리미엄 결제 로직 처리
	 *
	 * @param authKey
	 * @param customerKey
	 * @param model
	 * @return
	 */
	@GetMapping("/success2")
	public String success2(@RequestParam("authKey") String authKey, @RequestParam("customerKey") String customerKey,
			Model model) {

		// 권한 확인
		if (session.getAttribute("principal") == null) {
			throw new DataDeliveryException(Define.NOT_AN_AUTHENTICATED_USER, HttpStatus.BAD_REQUEST);
		}
		// 구독 진행중인지 확인
		PrincipalDTO principalDTO = (PrincipalDTO) session.getAttribute("principal");
		int userPk = principalDTO.getId();
		int duplication = paymentService.checkDuplication(userPk);

		if (duplication == 0) {
			try {
				// 주문 ID 생성
				String orderId = UUID.randomUUID().toString();
				String orderName = "premium";
				int amount = 12900;

				// 빌링키 발급과 자동 결제 실행
				String response = paymentService.authorizeBillingAndAutoPayment(authKey, customerKey, orderId,
						orderName, amount, userPk); // 금액은 실제 금액으로 대체

				return "payment/success";

			} catch (Exception e) {
				model.addAttribute("message", e.getMessage());
				throw new DataDeliveryException(Define.FAILED_PAYMENT, HttpStatus.BAD_REQUEST);
//				return "redirect:/pay/fail";
			}

		} else {
			throw new DataDeliveryException(Define.FAILED_SUBSCRIBE, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 결제 실패 페이지 요청
	 *
	 * @param message
	 * @param model
	 * @return
	 */
	@GetMapping("/fail")
	public String fail(@RequestParam(required = false) String message, Model model) {
		model.addAttribute("failMessage", message);
		return "payment/fail";
	}

	/**
	 * 결제 내역 전체 조회 페이지 요청
	 *
	 * @return payment/paymentList.jsp
	 */
	@GetMapping("/paymentList")
	public String paymentListPage() {
		// TODO - 삭제하면 안됨
//		if(session.getAttribute("admin") == null) {
//			throw new DataDeliveryException(Define.NOT_AN_AUTHENTICATED_USER, HttpStatus.BAD_REQUEST);
//		}
		return "payment/paymentList";
	}

	/**
	 * 결제내역, 취소내역 리스트 전체 조회 및 검색 기능 (페이징 처리 포함)
	 *
	 * @return board/paymentList.jsp
	 */
	@GetMapping("/searchPaymentList")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> paymentListPage(
			@RequestParam(name = "type", required = false) String type,
			@RequestParam(name = "searchRange", defaultValue = "", required = false) String searchRange,
			@RequestParam(name = "searchContents", defaultValue = "", required = false) String searchContents,
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size) {

		List<PaymentListDTO> paymentList = null;
		List<Refund> refundList = null;
		int totalCount = 0;
		int totalPages = 0;
		Map<String, Object> response = new HashMap<>();

		try {
			if (type.equals("paymentList")) {
				if (!searchContents.isEmpty()) {
					// 검색 조건이 있을 경우
					paymentList = paymentService.searchPayList(searchContents, page, size);
					totalCount = paymentService.getPayListCounts(searchContents);
				} else {
					// 검색 조건이 없을 경우
					System.out.println("결제 정보에 검색 조건이 없습니다.");
					paymentList = paymentService.getAllPayList(page, size);
					totalCount = paymentService.getPayListCounts();
				}

				totalPages = (int) Math.ceil((double) totalCount / size);

				response.put("paymentList", paymentList);

			} else if (type.equals("refundList")) {
				if (!searchContents.isEmpty() || !searchRange.isEmpty()) {
					// 검색 조건이 있을 경우
					refundList = paymentService.searchRefundList(searchRange, searchContents, page, size);
					totalCount = paymentService.getSearchRefundCounts(searchRange, searchContents);
				} else {
					// 검색 조건이 없을 경우
					refundList = paymentService.getAllrefundList(page, size);
					totalCount = paymentService.getRefundListCounts();
				}

				totalPages = (int) Math.ceil((double) totalCount / size);

				response.put("refundList", refundList);

			}

			response.put("totalCount", totalCount);
			response.put("totalPages", totalPages);
			response.put("currentPage", page);
			response.put("pageSize", size);

			Admin admin = (Admin) session.getAttribute("admin");
			if (admin != null) {
				response.put("admin", admin);
			}

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}

	}

	/**
	 * 결제 취소 페이지 요청
	 *
	 * @return payment/refundList.jsp
	 */
	@GetMapping("/refundList")
	public String cancelPage() {
		// TODO - 관리자인지 확인
//		if(session.getAttribute("admin") == null) {
//			throw new DataDeliveryException(Define.NOT_AN_AUTHENTICATED_USER, HttpStatus.BAD_REQUEST);
//		}
		return "payment/refundList";
	}

	/**
	 * 결제 취소 로직 처리
	 *
	 * @param orderId
	 * @param model
	 * @param paymentKey
	 * @param cancelReason
	 * @return
	 */
	@PostMapping("/refund")
	public String cancelPayment(@RequestParam(value = "orderId", required = false) String orderId, Model model,
			@RequestParam(value = "paymentKey", required = false) String paymentKey,
			@RequestParam(value = "cancelReason", required = false) String cancelReason,
			@RequestParam(value = "payPk", required = false) Integer payPk) {

		// 관리자 로그인 상태 체크
		Admin admin = (Admin) session.getAttribute("admin");
		int adminId = admin.getId();

		orderId = "2a8d00e4-2f78-4c1e-8ecc-8a6065cf6628";

		if (paymentKey != null && cancelReason != null) {

			if (orderId == null || orderId.isEmpty()) {
				model.addAttribute("message", "Order ID is required to cancel the payment.");
				return "redirect:/pay/fail";
			}

			try {
				// 결제 취소 실행
				String response = paymentService.cancelPayment(paymentKey, cancelReason, adminId, payPk);
				return "payment/cancel_success";
			} catch (Exception e) {
				model.addAttribute("message", e.getMessage());
				return "redirect:/pay/fail";
			}

		} else {
			model.addAttribute("message", "필수 파라미터가 누락되었습니다.");
			return "redirect:/pay/fail";
		}

	}
	/**
	 * 구독 유지 중인 구독자 수
	 * @return
	 */
	@GetMapping("/countSubscribing")
	@ResponseBody
	public int countSubscribing() {
		return paymentService.countSubscribing();
	}
	
	
	

}

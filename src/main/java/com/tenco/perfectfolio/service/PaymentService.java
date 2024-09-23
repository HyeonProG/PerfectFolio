package com.tenco.perfectfolio.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tenco.perfectfolio.dto.payment.PaymentDTO;
import com.tenco.perfectfolio.dto.payment.PaymentListDTO;
import com.tenco.perfectfolio.repository.interfaces.PaymentRepository;
import com.tenco.perfectfolio.repository.model.payment.Refund;
import com.tenco.perfectfolio.repository.model.payment.Subscribing;
import com.tenco.perfectfolio.utils.Define;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentService {

	@Value("${payment.toss.test-secret-api-key}")
	private String secretKey;
	@Autowired
	private PaymentRepository paymentRepository;
	private final ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * 결제 요청 로직
	 * @param authKey
	 * @param customerKey
	 * @param orderId
	 * @param orderName
	 * @param amount
	 * @param userPk
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public String authorizeBillingAndAutoPayment(String authKey, String customerKey, String orderId, String orderName,
			Integer amount, Integer userPk) throws Exception {
		String encodedAuthHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

		// 빌링키 발급과 동시에 자동 결제 수행
		HttpRequest billingRequest = HttpRequest.newBuilder()
				.uri(URI.create("https://api.tosspayments.com/v1/billing/authorizations/issue"))
				.header("Authorization", "Basic " + encodedAuthHeader).header("Content-Type", "application/json")
				.method("POST",
						HttpRequest.BodyPublishers
								.ofString("{\"authKey\":\"" + authKey + "\",\"customerKey\":\"" + customerKey + "\"}"))
				.build();

		HttpResponse<String> billingResponse = HttpClient.newHttpClient().send(billingRequest,
				HttpResponse.BodyHandlers.ofString());

		if (billingResponse.statusCode() == 200) {
			JsonNode billingJson = objectMapper.readTree(billingResponse.body());
			String billingKey = billingJson.get("billingKey").asText();

			// 자동 결제 요청
			HttpRequest paymentRequest = HttpRequest.newBuilder()
					.uri(URI.create("https://api.tosspayments.com/v1/billing/" + billingKey))
					.header("Authorization", "Basic " + encodedAuthHeader).header("Content-Type", "application/json")
					.method("POST",
							HttpRequest.BodyPublishers.ofString(
									"{\"customerKey\":\"" + customerKey + "\"," + "\"orderId\":\"" + orderId + "\","
											+ "\"orderName\":\"" + orderName + "\"," + "\"amount\":" + amount + "}"))
					.build();

			HttpResponse<String> paymentResponse = HttpClient.newHttpClient().send(paymentRequest,
					HttpResponse.BodyHandlers.ofString());

			if (paymentResponse.statusCode() == 200) {
				 JsonNode paymentJson = objectMapper.readTree(paymentResponse.body());

				 // 다음 결제일 계산
				 String dateFormatType = "yyyy-MM-dd";
				 Date toDay = new Date();
				 SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatType);
				 Calendar cal = Calendar.getInstance();
				 cal.setTime(toDay);
				 cal.add(Calendar.MONTH, +1);
				 String nextDate = simpleDateFormat.format(cal.getTime());
				 
				 // DTO 변환
				 PaymentDTO paymentDTO = PaymentDTO.builder()
						.userId(userPk)
						.lastTransactionKey(paymentJson.get("lastTransactionKey").asText())
						.paymentKey(paymentJson.get("paymentKey").asText())
						.orderId(paymentJson.get("orderId").asText())
						.orderName2(paymentJson.get("orderName").asText())
						.billingKey(billingKey)
						.customerKey(customerKey)
						.amount(amount)
						.totalAmount(paymentJson.get("totalAmount").asText())
						.requestedAt(paymentJson.get("requestedAt").asText())
						.approvedAt(paymentJson.get("approvedAt").asText())
						.cancel("N")
						.nextPay(nextDate)
						.build();
				paymentRepository.insert(paymentDTO.toPayment());
				paymentRepository.insertSubscribing(paymentDTO.toSubscribing());

				return paymentJson.toPrettyString();
			} else {

				// DTO 변환
				PaymentDTO errorPaymentDTO = PaymentDTO.builder()
						.userId(userPk).customerKey(customerKey)
						.billingKey(billingKey)
						.amount(amount)
						.orderId(orderId)
						.orderName(orderName)
						.billingErrorCode(billingResponse.statusCode())
						.payErrorCode(paymentResponse.statusCode())
						.build();
				paymentRepository.insertOrder(errorPaymentDTO.toOrder());

				throw new RuntimeException(Define.FAILED_PROCESS_PAYMENT + paymentResponse.body());
			}
		} else {
			throw new RuntimeException(Define.FAILED_ISSUE_BILLINGKEY + billingResponse.body());
		}
	}

	/**
	 * 결제 취소 로직
	 *
	 * @param paymentKey
	 * @param cancelReason
	 * @param userPk
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public String cancelPayment(String paymentKey, String cancelReason, int adminId, int payPk) throws Exception {

		String encodedAuthHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

		// 결제 취소 요청
		HttpRequest cancelRequest = HttpRequest.newBuilder()
				.uri(URI.create("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel"))
				.header("Authorization", "Basic " + encodedAuthHeader)
				.header("Content-Type", "application/json")
				.method("POST", HttpRequest.BodyPublishers.ofString("{\"cancelReason\":\"고객 변심\"}"))
				.build();

		HttpResponse<String> cancelResponse = HttpClient.newHttpClient().send(cancelRequest,
				HttpResponse.BodyHandlers.ofString());

		if ("200".equalsIgnoreCase(String.valueOf(cancelResponse.statusCode()))) {
			JsonNode cancelJson = objectMapper.readTree(cancelResponse.body());

			// DTO 변환
			PaymentDTO paymentDTO = PaymentDTO.builder()
					// TODO - 관리자 pk 입력 예정
					.lastTransactionKey(cancelJson.get("lastTransactionKey").asText())
					.paymentKey(paymentKey)
					.cancelReason(cancelReason)
					.requestedAt(cancelJson.get("requestedAt").asText())
					.approvedAt(cancelJson.get("approvedAt").asText())
					.cancelAmount("10000")
					.adminId(adminId)
					.build();

			paymentRepository.insertRefund(paymentDTO.toRefund());
			paymentRepository.update(payPk); // payment_tb에 cancel 유무 업데이트

			return cancelJson.toPrettyString();
		} else {
			throw new RuntimeException(Define.FAILED_CANCEL_PAYMENT + cancelResponse.body());
		}
	}

	/**
	 * 유저 결제 정보 확인
	 *
	 * @param userPk
	 * @return
	 */
	public Subscribing checkUserPayInfo(int userPk) {
		Subscribing subscribing = paymentRepository.checkUserPayInfo(userPk);
		return subscribing;
	}

	/**
	 * 이미 구독 중인지 체크
	 *
	 * @param userPk
	 * @return
	 */
	public int checkDuplication(int userPk) {
		int result = 0;
		result = paymentRepository.checkDuplication(userPk);
		return result;
	}

	/**
	 * 관리자에게 보여주기 위한 결제 리스트
	 *
	 * @return
	 */
	public List<PaymentListDTO> getAllPayList(int page, int size) {
		int offset = (page - 1) * size;
		List<PaymentListDTO> paymentList = new ArrayList<>();
		paymentList = paymentRepository.getAllPayList(size, offset);

		return paymentList;
	}

	/**
	 * 검색 조건없는 결제 내역 리스트 수
	 * @return
	 */
	public int getPayListCounts() {
		int count = 0;
		count = paymentRepository.getPayListCounts();
		return count;
	}

	/**
	 * 검색 조건없는 결제 취소 내역 리스트
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Refund> getAllrefundList(Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<Refund> refundList = new ArrayList<>();
		refundList = paymentRepository.getAllRefundList(size, offset);

		return refundList;
	}

	/**
	 * 검색 조건없는 결제 취소 내역 리스트 수
	 * @return
	 */
	public int getRefundListCounts() {
		int count = 0;
		count = paymentRepository.getRefundListCounts();
		return count;
	}

	/**
	 * 주문 번호로 검색한 결제 리스트
	 * @param searchContents
	 * @param page
	 * @param size
	 * @return
	 */
	public List<PaymentListDTO> searchPayList(String searchContents, Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<PaymentListDTO> paymentList = new ArrayList<>();
		paymentList = paymentRepository.getPayListsWithContents(searchContents,size, offset);
		return paymentList;
	}

	/**
	 * 주문 번호로 검색한 결제 리스트 수
	 * @param searchContents
	 * @return
	 */
	public int getPayListCounts(String searchContents) {
		int count = 0;
		count = paymentRepository.getPayCountsWithContents(searchContents);
		return count;
	}

	/**
	 * 취소 리스트 검색
	 * @param searchRange
	 * @param searchContents
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Refund> searchRefundList(String searchRange, String searchContents, Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<Refund> refundList = new ArrayList<>();

		if(!searchContents.isEmpty()) {
			refundList = paymentRepository.searchAllRefundList(searchRange,searchContents,size, offset);
		}else {
			refundList = paymentRepository.searchRefundListOnlyRange(searchRange,size, offset);
		}

		return refundList;
	}

	/**
	 * 취소 리스트 검색된 행 수
	 * @param searchRange
	 * @param searchContents
	 * @return
	 */
	public int getSearchRefundCounts(String searchRange, String searchContents) {
		int count = 0;
		if(!searchContents.isEmpty()) {
			count = paymentRepository.getAllRefundCounts(searchRange,searchContents);
		}else {
			count = paymentRepository.getRefundCountsWithContents(searchContents);
		}
		return count;
	}

	/**
	 * 정기결제 재요청
	 * @param customerKey
	 * @param billingKey
	 * @param userId
	 * @param orderName
	 * @param orderId
	 * @param amount
	 * @param userId2
	 */
	public void authorizeBillingAndAutoPayment(String customerKey, String billingKey, Integer userId, String orderId, String orderName,
			Integer amount,String payDay) {

		String encodedAuthHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

			// 자동 결제 요청
			HttpRequest paymentRequest = HttpRequest.newBuilder()
					.uri(URI.create("https://api.tosspayments.com/v1/billing/" + billingKey))
					.header("Authorization", "Basic " + encodedAuthHeader).header("Content-Type", "application/json")
					.method("POST",
							HttpRequest.BodyPublishers.ofString(
									"{\"customerKey\":\"" + customerKey + "\"," + "\"orderId\":\"" + orderId + "\","
											+ "\"orderName\":\"" + orderName + "\"," + "\"amount\":" + amount + "}"))
					.build();

			HttpResponse<String> paymentResponse = null;

			try {
				paymentResponse = HttpClient.newHttpClient().send(paymentRequest,
						HttpResponse.BodyHandlers.ofString());
			} catch (IOException | InterruptedException e) {
				e.printStackTrace();
			}

			if (paymentResponse.statusCode() == 200) {
				 JsonNode paymentJson;
				try {
					paymentJson = objectMapper.readTree(paymentResponse.body());
					
					 // 다음 결제일 계산
					 String dateFormatType = "yyyy-MM-dd";
					 Date toDay = new Date();
					 SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatType);
					 Calendar cal = Calendar.getInstance();
					 cal.setTime(toDay);
					 cal.add(Calendar.MONTH, +1);
					 String nextDate = simpleDateFormat.format(cal.getTime());
					
					// DTO 변환
					PaymentDTO paymentDTO = PaymentDTO.builder()
							.userId(userId)
							.lastTransactionKey(paymentJson.get("lastTransactionKey").asText())
							.paymentKey(paymentJson.get("paymentKey").asText())
							.orderId(paymentJson.get("orderId").asText())
							.orderName2(paymentJson.get("orderName").asText())
							.billingKey(billingKey)
							.customerKey(customerKey)
							.amount(amount)
							.totalAmount(paymentJson.get("totalAmount").asText())
							.requestedAt(paymentJson.get("requestedAt").asText())
							.approvedAt(paymentJson.get("approvedAt").asText())
							.cancel("N").build();
					paymentRepository.insert(paymentDTO.toPayment());
					paymentRepository.updateSubscribing(toDay,nextDate);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
			} else {
				// DTO 변환
				PaymentDTO errorPaymentDTO = PaymentDTO.builder()
						.userId(userId).customerKey(customerKey)
						.billingKey(billingKey)
						.amount(amount)
						.orderId(orderId)
						.orderName(orderName)
						.payErrorCode(paymentResponse.statusCode())
						.build();
				paymentRepository.insertOrder(errorPaymentDTO.toOrder());
				throw new RuntimeException(Define.FAILED_PROCESS_PAYMENT + paymentResponse.body());
			}
	}

	/**
	 * 구독해지 사유 입력
	 * @param terminationDTO
	 */
	public int termination(String cancelReason,Integer userPk) {
		int result = 0;
		paymentRepository.insertTerminReason(cancelReason,userPk);
		return result;
	}

	/**
	 * 구독 해지 상태로 업데이트
	 * @param userPk
	 */
	public int stopSubscribe(Integer userPk) {
		int result = 0;
		paymentRepository.updateStopSubscribe(userPk);
		return result;
	}
	
	/**
	 * 구독 유지 중인 구독자 수
	 * @return
	 */
	public int countSubscribing() {
		int result = paymentRepository.countSubscribing();
		return result;
	}
	

}
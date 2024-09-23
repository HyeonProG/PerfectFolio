package com.tenco.perfectfolio.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserApplicationDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserPaymentDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserRefundDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserRequestingRefundDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserSignInDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserSignUpDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserWithdrawDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.handler.exception.RedirectException;
import com.tenco.perfectfolio.repository.interfaces.advertiser.AdvertiserRepository;
import com.tenco.perfectfolio.repository.model.advertiser.Advertiser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdvertiserService {

	@Autowired
	private final AdvertiserRepository advertiserRepository;

	@Autowired
	private final PasswordEncoder passwordEncoder;

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Value("${payment.toss.test-secret-api-key}")
	private String secretKey;
	
	@Autowired
    private ResourceLoader resourceLoader;

	/**
	 * 아이디 중복 체크
	 */
	@Transactional
	public int checkId(String userId) {
		int result = advertiserRepository.checkDuplicateId(userId);

		if (result != 0) {
			return 1;
		}
		return 0;
	}

	/**
	 * 광고주 계정 생성
	 */
	@Transactional
	public void createAdvertiser(AdvertiserSignUpDTO dto) {
		System.out.println("signUp 메소드 동작");
		try {
			// 비밀번호 암호화
			String hashPwd = passwordEncoder.encode(dto.getPassword());
			dto.setPassword(hashPwd);
			int result = advertiserRepository.insert(dto.toAdvertiser());

			if (result != 1) {
				throw new DataDeliveryException("회원가입 실패", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} catch (DataAccessException e) {
			throw new DataDeliveryException("중복된 아이디를 사용할 수 없습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RedirectException("알 수 없는 오류", HttpStatus.SERVICE_UNAVAILABLE);
		}
	}

	/**
	 * 광고주 계정 불러오기
	 */
	@Transactional
	public Advertiser readAdvertiser(AdvertiserSignInDTO dto) {
		Advertiser advertiserEntity = advertiserRepository.findByUserId(dto.getUserId());

		if (advertiserEntity == null) {
			throw new DataDeliveryException("존재하지 않는 아이디 입니다.", HttpStatus.BAD_REQUEST);
		}

		boolean isPwdMatched = passwordEncoder.matches(dto.getPassword(), advertiserEntity.getPassword());
		if (!isPwdMatched) {
			throw new DataDeliveryException("비밀번호가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
		}

		return advertiserEntity;
	}

	/**
	 * 결제 승인 로직
	 * 
	 * @param orderId
	 * @param amount
	 * @param paymentKey
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public JSONObject confirmPayment(String orderId, Integer amount, String paymentKey, Integer userId)
			throws Exception {
		String secretKey = "test_sk_LkKEypNArWePvndZdKeL3lmeaxYG:";
		String authorizations = "Basic "
				+ Base64.getEncoder().encodeToString(secretKey.getBytes(StandardCharsets.UTF_8));

		URI uri = new URI("https://api.tosspayments.com/v1/payments/confirm");
		URL url = uri.toURL();
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Authorization", authorizations);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);

		JSONObject obj = new JSONObject();
		obj.put("orderId", orderId);
		obj.put("amount", amount);
		obj.put("paymentKey", paymentKey);

		try (OutputStream outputStream = connection.getOutputStream()) {
			outputStream.write(obj.toString().getBytes(StandardCharsets.UTF_8));
		}

		int code = connection.getResponseCode();
		InputStream responseStream = (code == 200) ? connection.getInputStream() : connection.getErrorStream();
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser
				.parse(new InputStreamReader(responseStream, StandardCharsets.UTF_8));

		if (code == 200) {
			// 결제 성공 시 Payment 테이블에 데이터 삽입
			String requestedAt = (String) jsonObject.get("requestedAt");
			String approvedAt = (String) jsonObject.get("approvedAt");

			AdvertiserPaymentDTO advertiserPaymentDTO = AdvertiserPaymentDTO.builder().userId(userId)
					.paymentKey(paymentKey).orderId(orderId).amount(amount).requestedAt(requestedAt)
					.approvedAt(approvedAt).build();

			// DB에 결제 정보 저장
			advertiserRepository.insertPayment(advertiserPaymentDTO);

			return jsonObject;
		} else {
			throw new Exception("Payment confirmation failed: " + jsonObject.get("message"));
		}
	}

	public List<AdvertiserPaymentDTO> readPaymentById(Integer userId) {
		return advertiserRepository.findPaymentListByUserId(userId);
	}

	/**
	 * 결제 환불
	 * 
	 * @param userId
	 * @param paymentKey
	 * @param cancelAmount
	 * @param cancelReason
	 * @return
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public String cancelAdvertiserPayment(Integer userId, String paymentKey, Integer cancelAmount, String cancelReason)
			throws IOException, InterruptedException {

		String encodedAuthHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

		HttpRequest cancelRequest = HttpRequest.newBuilder()
				.uri(URI.create("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel"))
				.header("Authorization", "Basic " + encodedAuthHeader).header("Content-Type", "application/json")
				.method("POST", HttpRequest.BodyPublishers.ofString("{\"cancelReason\":\"고객 변심\"}")).build();
		HttpResponse<String> cancelResponse = HttpClient.newHttpClient().send(cancelRequest,
				HttpResponse.BodyHandlers.ofString());
		System.out.println(cancelResponse.body());

		if ("200".equalsIgnoreCase(String.valueOf(cancelResponse.statusCode()))) {
			JsonNode cancelJson = objectMapper.readTree(cancelResponse.body());

			// DTO 변환
			AdvertiserRefundDTO advertiserRefundDTO = AdvertiserRefundDTO.builder().userId(userId)
					.paymentKey(paymentKey).cancelReason(cancelReason)
					.requestedAt(cancelJson.get("requestedAt").toString())
					.approvedAt(cancelJson.get("approvedAt").toString()).cancelAmount(cancelAmount).build();

			advertiserRepository.insertRefund(advertiserRefundDTO);

			return cancelJson.toString();
		} else {
			throw new RuntimeException("Failed to cancel payment: " + cancelResponse.body());
		}

	}

	/**
	 * 광고 신청
	 */
	@Transactional
	public void createAdApplication(AdvertiserApplicationDTO dto) {

		Advertiser advertiser = advertiserRepository.findById(dto.getUserId());
		if (advertiser.getBalance() <= 0) {
			throw new DataDeliveryException("잔액이 부족합니다.", HttpStatus.BAD_REQUEST);
		} else {
			if (dto.getMFile() != null && !dto.getMFile().isEmpty()) {
				String[] fileNames = uploadFile(dto.getMFile());
				dto.setOriginFileName(fileNames[0]);
				dto.setUploadFileName(fileNames[1]);
			}

			dto = AdvertiserApplicationDTO.builder().userId(dto.getUserId()).title(dto.getTitle())
					.content(dto.getContent()).site(dto.getSite()).originFileName(dto.getOriginFileName())
					.uploadFileName(dto.getUploadFileName()).build();

			int result = advertiserRepository.insertAd(dto);

			if (result != 1) {

				throw new DataDeliveryException("신청 실패", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}

	}

	/**
	 * 파일 업로드
	 */
	@Transactional
	public String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > 1024 * 1024 * 20) {
			throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.", HttpStatus.BAD_REQUEST);
		}

		String saveDirectory = null;

		try {
			saveDirectory = System.getProperty("user.dir") + "/src/main/resources/static/images/ad/";
			System.out.println("saveDirectory : " + saveDirectory);
			File dir = new File(saveDirectory);
		    if (!dir.exists()) {
		        dir.mkdirs(); // 디렉토리 생성
		    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		String originalFileName = mFile.getOriginalFilename();
		String uploadFileName = UUID.randomUUID() + "_" + originalFileName;
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		File destination = new File(uploadPath);
		System.out.println("UPLOADPATH : " + uploadPath);
		System.out.println("destination : " + destination);
		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new DataDeliveryException("파일 업로드 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { originalFileName, uploadFileName };
	}

	/**
	 * 광고주 잔액 업데이트
	 * 
	 * @param advertiserId 광고주의 ID
	 * @param amount       결제 금액
	 */
	@Transactional
	public void updateBalance(Integer id, Integer amount) {
		try {
			// 광고주의 현재 잔액 불러오기
			Advertiser advertiser = advertiserRepository.findById(id);
			if (advertiser == null) {
				throw new DataDeliveryException("광고주를 찾을 수 없습니다.", HttpStatus.BAD_REQUEST);
			}

			// 현재 잔액에 결제 금액 추가
			int newBalance = advertiser.getBalance() + amount;

			// 업데이트 로직
			int result = advertiserRepository.updateBalance(id, newBalance);

			if (result != 1) {
				throw new DataDeliveryException("잔액 업데이트 실패", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RedirectException("잔액 업데이트 중 오류가 발생했습니다.", HttpStatus.SERVICE_UNAVAILABLE);
		}
	}

	/**
	 * 광고 신청 리스트 불러오기
	 * 
	 * @return
	 */
	public List<AdvertiserApplicationDTO> readAllPendingApplications() {
		return advertiserRepository.findAllPendingApplications();
	}

	/**
	 * 광고주 아이디로 신청 리스트 불러오기
	 * 
	 * @param id
	 * @return
	 */
	public List<AdvertiserApplicationDTO> readAllPendingApplicationsById(Integer id, int page, int size) {
		int offset = (page - 1) * size;
		return advertiserRepository.findAllPendingApplicationsByIdWithPage(id, offset, size);
	}

	public List<AdvertiserApplicationDTO> readAllPendingApplicationsById(Integer id) {
		return advertiserRepository.findAllPendingApplicationsById(id);
	}

	/**
	 * 개인이 신청한 광고 내역 카운트
	 * 
	 * @param id
	 * @return
	 */
	public int countAllPendingApplicationsById(Integer id) {
		return advertiserRepository.countAllPendingApplicationsById(id);
	}

	/**
	 * 사용중인 광고 리스트 불러오기
	 * 
	 * @param userId
	 * @return
	 */
	public List<AdvertiserApplicationDTO> findUsingApplicationsById(Integer userId, int page, int size) {
		int offset = (page - 1) * size;
		return advertiserRepository.findUsingApplicationsByIdWithPage(userId, offset, size);
	}

	public List<AdvertiserApplicationDTO> findUsingApplicationsById(Integer userId) {
		return advertiserRepository.findUsingApplicationsById(userId);
	}

	public int countUsingApplicationsById(Integer userId) {
		return advertiserRepository.countFindUsingApplicationsById(userId);
	}

	/**
	 * 광고 상태 변경(광고주)
	 * 
	 * @param id
	 * @param state
	 * @return
	 */
	public int updateUsingApplication(Integer id, String state) {
		int result = advertiserRepository.updateAdApplicationState(id, state);

		if (result != 1) {
			throw new DataDeliveryException("광고 상태 변경을 실패하였습니다.", HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	/**
	 * 특정 광고 신청 불러오기
	 * 
	 * @param id
	 * @return
	 */
	public AdvertiserApplicationDTO readPendingApplicationDetail(Integer id) {
		return advertiserRepository.findApplicationById(id);
	}

	/**
	 * 광고 신청 취소
	 * 
	 * @param id
	 * @return
	 */
	@Transactional
	public String cancelAdApplication(Integer id) {

		// 광고 신청과 관련된 파일명을 DB에서 조회
		String imageFileName = advertiserRepository.findFileNameById(id);

		int result = advertiserRepository.deleteAdApplication(id);

		if (result != 1) {
			throw new RedirectException("광고 신청 취소 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return imageFileName;
	}

	/**
	 * 광고 신청 상태 변경
	 * 
	 * @param id
	 * @param state
	 */
	@Transactional
	public void updateApplicationState(Integer id, String state) {
		int result = advertiserRepository.updateAdApplicationState(id, state);

		if (result != 1) {
			throw new RedirectException("광고 신청 상태 업데이트 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 승인된 광고 목록 불러오기
	 * 
	 * @return
	 */
	@Transactional
	public List<AdvertiserApplicationDTO> readApproveApplications() {
		return advertiserRepository.findApproveApplications();
	}

	/**
	 * 광고 노출 카운트 업데이트
	 * 
	 * @param uploadFileName
	 * @param viewCount
	 */
	@Transactional
	public void updateImageViewCount(String uploadFileName, Integer viewCount) {
		advertiserRepository.updateImageViewCount(uploadFileName, viewCount);
	}

	/**
	 * 광고 클릭시 카운트 업데이트
	 * 
	 * @param uploadFileName
	 * @param clickCount
	 * @return
	 */
	@Transactional
	public int incrementClickCount(String uploadFileName, Integer clickCount) {
		System.out.println("clickCount : " + clickCount);
		return advertiserRepository.updateImageClickCount(uploadFileName, clickCount);
	}

	/**
	 * 광고주 잔액 불러오기
	 * 
	 * @param id
	 * @return
	 */
	@Transactional
	public int getBalance(Integer id) {
		return advertiserRepository.findBalanceById(id);
	}

	/**
	 * 모든 광고주 불러오기
	 * 
	 * @return
	 */
	@Transactional
	public List<Advertiser> findAllUser() {
		return advertiserRepository.findAllUser();
	}

	// 페이지네이션된 대기 중인 광고 신청 목록을 반환하는 메서드
	public List<AdvertiserApplicationDTO> readPendingApplications(int page, int size) {
		int offset = (page - 1) * size;
		return advertiserRepository.findPendingApplications(offset, size);
	}

	// 전체 대기 중인 광고 신청 수를 반환하는 메서드
	public int countPendingApplications() {
		return advertiserRepository.countPendingApplications();
	}

	/**
	 * 광고주 회원 탈퇴
	 * 
	 * @param advertsier
	 * @param withdrawDTO
	 */
	@Transactional
	public void withdrawAdvertsier(Advertiser advertsier, AdvertiserWithdrawDTO withdrawDTO) {

		// 사용자 정보를 가져옴
		Advertiser advertiser = advertiserRepository.findById(advertsier.getId());
		System.out.println("advertiser : " + advertiser);

		if (withdrawDTO.getReason() != null && !withdrawDTO.getReason().isEmpty()) {
			// 광고주 탈퇴 테이블로 인서트
			advertiserRepository.insertWithdraw(advertiser);

			// 탈퇴 사유 인서트
			int a = advertiserRepository.insertWithdrawReason(advertiser.getUserId(), withdrawDTO.getReason());

			// 사용자 정보를 삭제
			int b = advertiserRepository.deleteAdvertiser(advertsier.getUserId());

		} else {
			throw new DataDeliveryException("탈퇴 사유를 입력하세요.", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 3년이 지난 탈퇴 회원 삭제
	 */
	public void deleteOldWithdraw() {
		advertiserRepository.deleteOldWithdraw();
	}

	/**
	 * 검색 조건 없는 결제 리스트 (환불하기 위함)
	 * 
	 * @param page
	 * @param size
	 * @return
	 */
	public List<AdvertiserPaymentDTO> readAllPaymentList(Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<AdvertiserPaymentDTO> refundList = new ArrayList<>();
		refundList = advertiserRepository.readAllPaymentList(size, offset);

		return refundList;
	}

	/**
	 * 검색 조건 없는 전체 결제 리스트 수
	 * 
	 * @return
	 */
	public int getPayListCounts() {
		int count = 0;
		count = advertiserRepository.getPayListCounts();
		return count;
	}

	/**
	 * 광고주 마이페이지 > 환불 요청
	 * 
	 * @param dto
	 */
	@Transactional
	public int createRequestRefund(AdvertiserRequestingRefundDTO dto) {
		int result = 0;
		result = advertiserRepository.insertRequestRefund(dto);
		return result;
	}

	/**
	 * 환불 요청 리스트 (검색 조건 X)
	 * 
	 * @param page
	 * @param size
	 * @return
	 */
	public List<AdvertiserRequestingRefundDTO> readAllRequestList(Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<AdvertiserRequestingRefundDTO> refundList = new ArrayList<>();
		System.out.println("페이지와 사이즈 : " + page + size);
		refundList = advertiserRepository.readAllRequestList(size, offset);
		return refundList;
	}

	/**
	 * 환불 요청 리스트 수 (검색 조건 X)
	 * 
	 * @return
	 */
	public int getRequestListCounts() {
		int count = 0;
		count = advertiserRepository.getRequestListCounts();
		return count;
	}

	/**
	 * 광고 전체 뷰 카운트 조회
	 * 
	 * @return
	 */
	public Integer countAllViewCount() {
		int count = advertiserRepository.countAllViewCount();
		return count;
	}

	/**
	 * 광고 전체 클릭 카운트 조회
	 * 
	 * @return
	 */
	public Integer countAllClickCount() {
		int count = advertiserRepository.countAllClickCount();
		return count;
	}

	/**
	 * 전체 광고주 결제 카운트 조회
	 * 
	 * @return
	 */
	public Integer countAllAdPayment() {
		int count = advertiserRepository.countAllAdPayment();
		return count;
	}

	/**
	 * 광고주 전체 환불 카운트 조회
	 * 
	 * @return
	 */
	public Integer countAllAdRefundPayment() {
		int count = advertiserRepository.countAllAdRefundPayment();
		return count;
	}

	/**
	 * 광고주 환불 요청 관리자가 승인, 반려 처리
	 * 
	 * @param treatment
	 */
	@Transactional
	public int treatment(String treatment, int id, String reject) {
		int result = 0;
		result = advertiserRepository.updateTreatment(treatment, id, reject);
		return result;
	}
	
	/**
	 * 광고주 전체 환불 금액 카운트
	 * @return
	 */
	public Integer countAllAdRefundAmount() {
		int count = advertiserRepository.countAllAdRefundAmount();
		return count;
	}

	/**
	 * 광고주 마이페이지 > 환불 요청한 내역
	 * @param page
	 * @param size
	 * @return
	 */
	public List<AdvertiserRequestingRefundDTO> readRequestList(Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<AdvertiserRequestingRefundDTO> refundList = new ArrayList<>();
		refundList = advertiserRepository.readRequestList(size, offset);
		return refundList;
	}

	/**
	 * 광고주 마이페이지 > 처리 완료된 환불 내역
	 * @param page
	 * @param size
	 * @return
	 */
	public List<AdvertiserRequestingRefundDTO> readDoneRequestList(Integer page, Integer size) {
		int offset = (page - 1) * size;
		List<AdvertiserRequestingRefundDTO> refundList = new ArrayList<>();
		refundList = advertiserRepository.readDoneRequestList(size, offset);
		return refundList;
	}


}

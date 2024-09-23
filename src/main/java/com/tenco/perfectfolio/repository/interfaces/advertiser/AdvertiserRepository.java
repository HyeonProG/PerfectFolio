package com.tenco.perfectfolio.repository.interfaces.advertiser;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.dto.advertiser.AdvertiserApplicationDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserPaymentDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserRefundDTO;
import com.tenco.perfectfolio.dto.advertiser.AdvertiserRequestingRefundDTO;
import com.tenco.perfectfolio.repository.model.advertiser.Advertiser;

@Mapper
public interface AdvertiserRepository {

    // 광고주 등록
    public int insert(Advertiser advertiser);

    // 아이디 중복 체크
    public int checkDuplicateId(String userId);
    
    // 유저 아이디로 광고주 찾기
    public Advertiser findByUserId(String id);
    
    // 모든 광고주 불러오기
    public List<Advertiser> findAllUser();
    
    // 결제 신청
    public int insertPayment(AdvertiserPaymentDTO advertiserPaymentDTO);
    
    // 광고주 개인 결제 내역 불러오기
    public List<AdvertiserPaymentDTO> findPaymentListByUserId(Integer userId);
  
    // 광고주 환불 신청
    public int updateRefundByUserId(Integer userId);
    
    // 환불 신청
    public int insertRefund(AdvertiserRefundDTO advertiserRefundDTO);
    
    // 광고 신청
    public int insertAd(AdvertiserApplicationDTO advertiserApplicationDTO);

    // 광고주 ID로 광고주 정보 찾기
    public Advertiser findById(@Param("id") Integer id);
    
    // 광고주의 잔액 업데이트
    public int updateBalance(@Param("id") Integer id, @Param("newBalance") Integer newBalance);

    // 광고 상태 업데이트
    public int updateAdApplicationState(@Param("id") Integer id, @Param("state") String state);
    
    // 광고 신청 취소
    public int deleteAdApplication(Integer id);
    
    // 승인 대기 광고 신청 목록 조회
    public List<AdvertiserApplicationDTO> findPendingApplications();
    
    // 사용중인 광고 목록 조회(페이징)
    public List<AdvertiserApplicationDTO> findUsingApplicationsByIdWithPage(@Param("id") Integer userId, @Param("offset") int offset, @Param("size") int size);

    // 사용중인 광고 목록 조회
    public List<AdvertiserApplicationDTO> findUsingApplicationsById(@Param("id") Integer userId);
    
    // 사용중인 광고 목록 조회(카운트)
    public int countFindUsingApplicationsById(@Param("id") Integer id);
    
    // 승인 대기 광고 디테일 조회
    public AdvertiserApplicationDTO findApplicationById(@Param("id") Integer id);

    // 승인 광고 목록 조회
    public List<AdvertiserApplicationDTO> findApproveApplications();
    
    // 광고 노출 당 뷰 카운트 업데이트
    public int updateImageViewCount(@Param("uploadFileName") String uploadFileName, @Param("viewCount") Integer viewCount);
    
    // 광고주 잔액 조회
    public int findBalanceById(@Param("id") Integer id);

    // 광고 신청과 연결된 이미지 파일 조회
	public String findFileNameById(@Param("id") Integer id);

	// 광고 클릭시 카운트 업데이트
	public int updateImageClickCount(@Param("uploadFileName")String uploadFileName, @Param("clickCount")Integer clickCount);

	// 페이지네이션된 대기 중인 광고 신청 목록을 가져오는 메서드
    List<AdvertiserApplicationDTO> findPendingApplications(@Param("offset") int offset, @Param("size") int size);

    // 대기중인 광고 신청 목록 가져오기
    List<AdvertiserApplicationDTO> findAllPendingApplications();
    
    // 광고주 개인 대기중인 광고 신청 목록 가져오기(페이징)
    List<AdvertiserApplicationDTO> findAllPendingApplicationsByIdWithPage(@Param("id") Integer id, @Param("offset") int offset, @Param("size") int size);

    // 광고주 개인 대기중인 광고 신청 목록 가져오기
    List<AdvertiserApplicationDTO> findAllPendingApplicationsById(@Param("id") Integer id);
    
    // 광고주 개인 대기중인 광고 신청 목록 가져오기(카운트)
    public int countAllPendingApplicationsById(@Param("id") Integer id);
    
    // 전체 대기 중인 광고 신청 수를 가져오는 메서드
    public int countPendingApplications();
	
    // 광고주 탈퇴 테이블로 추가
    public int insertWithdraw(Advertiser advertiser);

    // 광고주 탈퇴 사유
    public int insertWithdrawReason(@Param("userId") String userId, @Param("reason") String reason);

    // 광고주 테이블에서 삭제
    public int deleteAdvertiser(@Param("userId") String userId);

    // 탈퇴 3년이 지난 회원 삭제
    public void deleteOldWithdraw();

    // 검색 조건없는 결제 리스트
	public List<AdvertiserPaymentDTO> readAllPaymentList(@Param("size") Integer size, @Param("offset") int offset);
	// 검색 조건없는 결제 리스트 수
	public int getPayListCounts();
	// 광고주 환불 요청
	public int insertRequestRefund(AdvertiserRequestingRefundDTO dto);
	// 환불 요청 리스트(검색 조건 X)
	public List<AdvertiserRequestingRefundDTO> readAllRequestList(@Param("size") Integer size, @Param("offset") int offset);
	// 환불 요청 리스트 수 (검색 조건 X)
	public int getRequestListCounts();
	// 환불 요청 관리자가 승인, 반려 처리
	public int updateTreatment(@Param("treatment") String treatment ,@Param("id") int id,@Param("reject") String reject);
	
	// 전체 뷰 카운트
	public int countAllViewCount();
	
	// 전체 클릭 카운트
	public int countAllClickCount();
	
	// 전체 광고주 결제 카운트
	public int countAllAdPayment();
	
	// 광고주 처리 대기중인 환불 신청 내역만
	public List<AdvertiserRequestingRefundDTO> readRequestList(@Param("size") Integer size, @Param("offset") int offset);
	
	// 광고주 마이페이지 > 처리 완료된 환불 요청 내역
	public List<AdvertiserRequestingRefundDTO> readDoneRequestList(@Param("size") Integer size, @Param("offset") int offset);
	
	// 광고주 전체 환불 내역 카운트
	public int countAllAdRefundPayment();
	
	// 광고주 전체 환불 금액 카운트
	public int countAllAdRefundAmount();
	
}

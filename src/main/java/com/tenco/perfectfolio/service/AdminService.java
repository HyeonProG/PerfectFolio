package com.tenco.perfectfolio.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.dto.WithdrawDTO;
import com.tenco.perfectfolio.dto.admin.AdminDTO;
import com.tenco.perfectfolio.dto.admin.AdminUserInfoDTO;
import com.tenco.perfectfolio.dto.admin.UserCountDTO;
import com.tenco.perfectfolio.dto.admin.UserManagementDTO;
import com.tenco.perfectfolio.dto.admin.UsersCountByWeekDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.interfaces.admin.AdminUserRepository;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.repository.model.admin.UsersCountByWeekModel;
import com.tenco.perfectfolio.utils.Define;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

    @Autowired
    private AdminUserRepository adminUserRepository;
    
    @Autowired
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public Integer countRegisterUserPerday(String date){
        //컨트롤러에서 date 변수 유효성 검사 필수 !! 포맷 확인 yyyy-mm-dd
        Integer count = adminUserRepository.countRegisterUsersByDate(date);
        return count;
    }
    
    @Transactional
    public List<UsersCountByWeekDTO> countUsersActPerWeek(String startDate, String endDate){
        List<UsersCountByWeekModel> weekModelList = adminUserRepository.countUsersActByWeek(startDate, endDate);
        List<UsersCountByWeekDTO> weekDTOList = new ArrayList<>();

        for (UsersCountByWeekModel weekModel : weekModelList) {
            weekDTOList.add(weekModel.buildUsersCountByWeekDTO());
        }

        return weekDTOList;
    }
   
    
    /**
     * 모든 사용자 조회
     * @param offset
     * @param limit
     * @return
     */
    @Transactional
    public List<AdminUserInfoDTO> selectAllUsers(int offset, int limit){
        List<User> userList = adminUserRepository.selectAllUsers(offset, limit);
        List<AdminUserInfoDTO> userDTOList = new ArrayList<>();

        for (User user : userList) {
            userDTOList.add(user.toDTO());
        }
        return userDTOList;
    }

    /**
     * 오늘 가입한 사용자 조회
     * @param offset
     * @param limit
     * @return
     */
    @Transactional
    public List<AdminUserInfoDTO> selectTodayRegisterUsers(int offset, int limit){
        List<User> userList = adminUserRepository.selectTodayRegisterUsers(offset, limit);
        List<AdminUserInfoDTO> userDTOList = new ArrayList<>();

        for (User user : userList) {
            userDTOList.add(user.toDTO());
        }
        return userDTOList;
    }
    
    /**
     * 전체 사용자 수 조회
     * @return
     */
    public Integer countAllUsers() {
    	int count = adminUserRepository.countAllUsers();
    	return count;
    }
    
    /**
     * 월별 전체 사용자 수 조회
     * @return
     */
    public List<UserCountDTO> countAllUsersByMonth() {
    	List<UserCountDTO> userList = adminUserRepository.countAllUsersByMonth();
    	return userList;
    }
    
    /**
     * 남/여/설정안함 사용자 수 조회
     * @return
     */
    public List<UserCountDTO> countUserByGender() {
    	List<UserCountDTO> genderCount = adminUserRepository.countUserByGender();
    	  // 성별이 null인 경우 '설정안함'으로 설정
        for (UserCountDTO dto : genderCount) {
            if (dto.getGender() == null || dto.getGender() == "") {
                dto.setGender("설정안함");
            }
        }
    	return genderCount;
    }
    
    /**
     * 소셜 타입별 사용자 수 조회
     * @return
     */
    public List<UserCountDTO> countUserBySocialType() {
    	List<UserCountDTO> socialType = adminUserRepository.countUserBySocialType();
    	return socialType;
    }
    
    /**
     * 연령별 사용자 수 조회
     * @return
     */
    public List<UserCountDTO> countUserByAge() {
    	List<UserCountDTO> countAge = adminUserRepository.countUserByAge();
    	return countAge;
    }
    
    /**
     * 관리자 존재 여부 조회
     * @param adminId
     * @return
     */
    public AdminDTO findAdminInfo(String adminId) {
    	Admin admin = adminUserRepository.findAdminInfo(adminId);
    	if(admin != null) {
    		AdminDTO dto = AdminDTO.builder()
    				.id(admin.getId())
    				.adminName(admin.getAdminName())
    				.adminEmail(admin.getAdminEmail())
    				.build();
    		return dto;
    	}
    	return null;
    }
    
    //**** 관리자 정보 ****\\
    
    /**
     * 관리자 정보 조회
     * 
     * @param adminId
     * @return
     */
    public Admin searchAdmin(String adminId) {
    	Admin admin = adminUserRepository.findAdminInfo(adminId);
    	if(admin != null) {
    		return admin;
    	}
    	return null;
    }
    
    
    /**
     * 관리자 비밀번호 변경
     * @param adminId
     * @return
     */
    @Transactional
    public void updatePassword(String newPassword, String adminId) {
    	
    	// 비밀번호 해싱
    	String hashPwd = passwordEncoder.encode(newPassword);
    	
    	// 해싱한 비밀번호 업데이트
    	adminUserRepository.updatePassword(hashPwd, adminId);
    }
    
    //**** 회원 관리 ****\\
   
    /**
     * 사용자 정보 수정
     * @param dto
     * @return
     */
    @Transactional
    public int updateUserInfo(User user) {
    	int result = 0;
    	
    	String hashPwd = passwordEncoder.encode(user.getUserPassword());
    	user.setUserPassword(hashPwd);
    	result = adminUserRepository.updateUserInfo(user);
    	if(result == 0) {
    		throw new DataDeliveryException(Define.PROCESS_FAIL, HttpStatus.BAD_REQUEST);
    	}
    	return result;
    }
    
    /**
     * 사용자 정보 삭제
     * @param id
     */
    @Transactional
    public void withdrawUser(int id) {
    	User user = adminUserRepository.findUserById(id);
    	adminUserRepository.insertWithdraw(user);
    	adminUserRepository.deleteUserInfo(user.getId());
    }
    
    /**
     *  사용자 정보 상세보기
     * @param id
     * @return
     */
    @Transactional
    public User getDetailUserInfo(int id) {
    	return adminUserRepository.findUserById(id);
    	
    }
    
    
    /**
     * 사용자 전체 정보 조회 + 결제일
     * 페이징 처리
     * @param page
     * @param size
     * @return
     */
    public List<UserManagementDTO> selectUserAllWithPay(int page, int size) {
    	List<UserManagementDTO> list = new ArrayList<>();
    	int limit = size;
    	int offset = (page - 1) * size;
    	list = adminUserRepository.selectUserAllWithPay(limit, offset);
    	return list;
    }
    
    /**
     * 회원 검색 및 페이징 처리
     * @param searchType
     * @param keyword
     * @param page
     * @param size
     * @return
     */
    public List<UserManagementDTO> searchUser(String searchType, String keyword, int page, int size) {
    	int limit = size;
    	int offset = (page - 1) * size;
    	
    	List<UserManagementDTO> userList = null;
    	switch (searchType) {
		case "userId":
			userList = adminUserRepository.searchByUserId("%" + keyword + "%", limit, offset);
			break;
		case "username":
			userList = adminUserRepository.searchByUserName("%" + keyword + "%", limit, offset);
			break;
		case "userNickname":
			userList = adminUserRepository.searchByUserNickName("%" + keyword + "%", limit, offset);
			break;
		default:
			throw new IllegalArgumentException("Invalid search type:" + searchType);
		}
    	return userList;
    }
    
    /**
     * 검색 결과 수 반환
     * @param searchType
     * @param keyword
     * @return
     */
    public int getSearchCount(String searchType, String keyword) {
    	int count = 0;
    	
    	switch (searchType) {
		case "userId":
			count = adminUserRepository.searchByUserIdCount("%" + keyword + "%");
			break;
		case "username":
			count = adminUserRepository.searchByUserNameIdCount("%" + keyword + "%");
			break;
		case "userNickname":
			count = adminUserRepository.searchByUserNickNameCount("%" + keyword + "%");
			break;
		default:
			throw new IllegalArgumentException("Invalid search type:" + searchType);
		}
    	return count;
    }
    
    /**
     * 탈퇴 회원 전체 정보 조회 + 탈퇴 사유
     * 페이징 처리
     * @param page
     * @param size
     * @return
     */
    public List<WithdrawDTO> selectWithdraw(int page, int size) {
    	List<WithdrawDTO> list = new ArrayList<>();
    	int limit = size;
    	int offset = (page - 1) * size;
    	list = adminUserRepository.selectWithdraw(limit, offset);
    	return list;
    }
    
    /**
     * 탈퇴 회원 수 
     * @return
     */
    public int getCountWithdraw() {
    	int count = 0;
    	count = adminUserRepository.countWithdraw();
    	return count;
    }
    
    /**
     * 탈퇴 사유 및 개수 조회(통계)
     * @return
     */
    public List<UserCountDTO> countWithdrawReason() {
    	List<UserCountDTO> reason = adminUserRepository.countWithdrawReason();
    	return reason;
    }
    
    /**
     * 탈퇴 사유 상세보기(검색)
     * 페이징처리
     * @return
     */
    public List<WithdrawDTO> searchReasonDetail(String searchType, int page, int size) {
    	List<WithdrawDTO> reasonDetail = new ArrayList<>();
    	int limit = size;
    	int offset = (page - 1) * size;
    	reasonDetail = adminUserRepository.searchReasonDetail(limit, offset);
    	return reasonDetail;
    }
    
    /**
     * 탈퇴 사유 상세보기 개수
     * @return
     */
    public int countReasonDetail(String searchType) {
    	int count = 0;
    	count = adminUserRepository.countReasonDetail();
    	return count;
    }

    /**
     * 유저 -> 구독 해지자 수
     * @author hj
     * @return
     */
	public Integer countUnsubscribe() {
		Integer unsubscribe = adminUserRepository.countUnsubscribe();
    	return unsubscribe;
	}

	/**
	 * 유저 -> 전체 구독 결제 금액
	 * @return
	 */
	public Integer countAllSubAmount() {
		int count = 0;
    	count = adminUserRepository.countAllSubAmount();
    	return count;
	}

	/**
	 * 유저 -> 전체 환불 금액
	 * @return
	 */
	public Integer countAllSubRefund() {
		int count = 0;
    	count = adminUserRepository.countAllSubRefund();
    	return count;
	}
    
    
    
}

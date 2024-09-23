package com.tenco.perfectfolio.repository.interfaces.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.dto.WithdrawDTO;
import com.tenco.perfectfolio.dto.admin.UserCountDTO;
import com.tenco.perfectfolio.dto.admin.UserManagementDTO;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.repository.model.admin.UsersCountByWeekModel;

@Mapper
public interface AdminUserRepository {

    //일,월 별 사용자 가입 추이
    public Integer countRegisterUsersByDate(String date);
    public List<Integer> countRegisterUsersByYear(String year);

    //일,월 별 사용자 탈퇴 추이
    public int countResignUsersByDate(String date);
    public List<Integer> countResignUsersByYear(String year);

    //주별 사용자 가입 탈퇴 동시 추출
    public List<UsersCountByWeekModel> countUsersActByWeek(@Param("startDate") String startDate, @Param("endDate") String endDate);

    // 관리자 정보 조회
    public Admin findAdminInfo(String adminId);
    
    // 관리자 비밀번호 변경
    public void updatePassword(@Param("newPassword") String newPassword, @Param("adminId") String adminId);
    
    //모든 사용자 조회
    public List<User> selectAllUsers(int offset, int limit);

    //오늘 가입한 사용자 조회
    public List<User> selectTodayRegisterUsers(int offset, int limit);
    
    
    // 월별 모든 사용자 수 조회
    public List<UserCountDTO> countAllUsersByMonth();
    
    // 남/여/설정안함 사용자 수 조회
    public List<UserCountDTO> countUserByGender();
    
    // 소셜 타입 사용자 수 조회
    public List<UserCountDTO> countUserBySocialType();
    
    // 연령별 사용자 수 조회
    public List<UserCountDTO> countUserByAge();
    
    // 회원 전체 정보 조회
    public List<UserManagementDTO> selectUserAllWithPay(@Param("limit") Integer limit, @Param("offset")Integer offset);
    
    // 모든 사용자 수 조회
    public Integer countAllUsers();
    
    // 회원 검색 - 사용자 아이디
    public List<UserManagementDTO> searchByUserId(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
    public Integer searchByUserIdCount(@Param("keyword") String keyword);
    
    // 회원 검색 - 사용자 이름
    public List<UserManagementDTO> searchByUserName(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
    public Integer searchByUserNameIdCount(@Param("keyword") String keyword);
    
    // 회원 검색 - 사용자 닉네임
    public List<UserManagementDTO> searchByUserNickName(@Param("keyword") String keyword, @Param("limit") Integer limit, @Param("offset")Integer offset);
    public Integer searchByUserNickNameCount(@Param("keyword") String keyword);
    
    // 회원 정보 수정
    public int updateUserInfo(User user);
    
    // 회원 삭제
    public void deleteUserInfo(int id);
    public int insertWithdraw(User user); 
    
    // PK 값으로 회원 조회(상세보기)
    public User findUserById(int id);
    
    // 탈퇴한 회원 조회
    public List<WithdrawDTO> selectWithdraw(@Param("limit") Integer limit, @Param("offset") Integer offset);
    
    //탈퇴한 회원 수
    public Integer countWithdraw();
    
    // 탈퇴 사유 및 개수 조회(통계)
    public List<UserCountDTO> countWithdrawReason();
    
    // 탈퇴 사유 상세보기 조회(검색)
    public List<WithdrawDTO> searchReasonDetail(@Param("limit") Integer limit, @Param("offset") Integer offset);
    
    // 탈퇴 사유 상세보기 개수
    public Integer countReasonDetail();
    
    // 유저 -> 구독 해지자 수
	public Integer countUnsubscribe();
	// 유저 -> 전체 구독 결제 금액
	public int countAllSubAmount();
	// 유저 -> 전체 환불 금액
	public int countAllSubRefund();
}

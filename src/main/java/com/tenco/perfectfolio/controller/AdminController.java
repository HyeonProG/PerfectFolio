package com.tenco.perfectfolio.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tenco.perfectfolio.dto.ChangePasswordDTO;
import com.tenco.perfectfolio.dto.SignInDTO;
import com.tenco.perfectfolio.dto.WithdrawDTO;
import com.tenco.perfectfolio.dto.admin.AdminDTO;
import com.tenco.perfectfolio.dto.admin.AdminUserInfoDTO;
import com.tenco.perfectfolio.dto.admin.UserCountDTO;
import com.tenco.perfectfolio.dto.admin.UserManagementDTO;
import com.tenco.perfectfolio.dto.admin.UsersCountByWeekDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.handler.exception.DataFormatException;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.admin.Admin;
import com.tenco.perfectfolio.service.AdminService;
import com.tenco.perfectfolio.utils.Define;
import com.tenco.perfectfolio.utils.ValidationUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private HttpSession session;
	@Autowired
	private PasswordEncoder passwordEncoder;

	// return calculatorTest.jsp
	@GetMapping("/test1")
	public String calculator() {
		return "admin/calculatorTest";
	}
//
//	/**
//	 *
//	 * URL : http://localhost:8080/admin/count-register/day?date=2024-08-26
//	 * 
//	 * @return Inteaer
//	 */
//	@GetMapping("/count-register/day")
//	@ResponseBody
//	public Integer registerStatisticsPerDay(@RequestParam String date) {
//		// TODO - date type (YYYY-MM-DD) 이 맞느지 확인 사실상 틀릴일 없음
//		// 프론트 단에서 확인후 서버로 전송 그냥 진짜 만약
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//		try {
//			LocalDate.parse(date, formatter);
//		} catch (DateTimeParseException e) {
//			throw new DataFormatException("날짜 형식이 올바르지 않습니다.", HttpStatus.BAD_REQUEST);
//		}
//
//		
//	}

	/**
	 * 주 단위별 사용가 가입, 탈퇴 수 통계 URL :
	 * http://localhost:8080/admin/count-all/week?startDate=2024-08-25&endDate=2024-08-31
	 * 
	 * @param startDate : 검색 시작일
	 * @param endDate   : 검색 종료일
	 * @return List<?>
	 */
	@GetMapping("/count-all/week")
	@ResponseBody
	public List<UsersCountByWeekDTO> registerStatisticsPerWeek(@RequestParam(value = "startDate") String startDate,
			@RequestParam(value = "endDate") String endDate) {
		// TODO - date type (YYYY-MM-DD) 이 맞느지 확인 사실상 틀릴일 없음
		// 프론트 단에서 확인후 서버로 전송 그냥 진짜 만약
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		try {
			LocalDate.parse(startDate, formatter);
			LocalDate.parse(endDate, formatter);
		} catch (DateTimeParseException e) {
			throw new DataFormatException("날짜 형식이 올바르지 않습니다.", HttpStatus.BAD_REQUEST);
		}

		return adminService.countUsersActPerWeek(startDate, endDate);
	}

	/**
	 * 모든 사용자 조회 URL : http://localhost:8080/admin/user/getAll?offset=0&limit=10
	 * 
	 * @param offset
	 * @param limit
	 * @return List<User>
	 */
	@GetMapping("/user/getAll")
	@ResponseBody
	public List<AdminUserInfoDTO> getAllUsers(@RequestParam int offset, @RequestParam int limit) {
		return adminService.selectAllUsers(offset, limit);
	}

	/**
	 * 오늘 가입한 사용자 조회 URL :
	 * http://localhost:8080/admin/user/get-today?offset=0&limit=10
	 * 
	 * @return List<User>
	 */
	@GetMapping("/user/get-today")
	@ResponseBody
	public List<AdminUserInfoDTO> getTodayRegisterUsers(@RequestParam int offset, @RequestParam int limit) {
		return adminService.selectTodayRegisterUsers(offset, limit);
	}

	/**
	 * 일별 사용자 가입 수 통계 URL :
	 * http://localhost:8080/admin/count-register/day?date=2024-08-26
	 * 
	 * @return Inteaer
	 */
	@GetMapping("/count-register/day")
	@ResponseBody
	public Integer registerStatisticsPerDay(@RequestParam String date) {
		// TODO - date type (YYYY-MM-DD) 이 맞느지 확인 사실상 틀릴일 없음
		// 프론트 단에서 확인후 서버로 전송 그냥 진짜 만약
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		try {
			LocalDate.parse(date, formatter);
		} catch (DateTimeParseException e) {
			throw new DataFormatException("날짜 형식이 올바르지 않습니다.", HttpStatus.BAD_REQUEST);
		}
		return adminService.countRegisterUserPerday(date);
	}
	
	//**** 통계 페이지 ****\\

	/**
	 * 관리자 페이지의 통계 페이지
	 * @return
	 */
	@GetMapping("/chart")
	public String chartPage() {
		return "admin/chart";
	}
	
	
	/**
	 * 전체 사용자 수
	 * @return
	 */
	@GetMapping("/chartCountAllUsers")
	@ResponseBody
	public Integer countAllUsers() {
		return adminService.countAllUsers();
	}

	/**
	 * 월별 사용자 수
	 * @return
	 */
	@GetMapping("/chartCountUserByMonth")
	@ResponseBody
	public List<UserCountDTO> countAllUsersByMonth() {
	    return adminService.countAllUsersByMonth();
	}
	
	/**
	 * 남/여/설정안함 사용자 수
	 * @return
	 */
	@GetMapping("/chartCountUserByGender")
	@ResponseBody
	public List<UserCountDTO> countUserByGender() {
		return adminService.countUserByGender();
	}
	
	/**
	 * 소셜 타입별 사용자 수
	 * @return
	 */
	@GetMapping("/chartCountUserBySocialType")
	@ResponseBody
	public List<UserCountDTO> countUserBySocialType() {
		return adminService.countUserBySocialType();
	}
	
	/**
	 * 연령별 사용자 수 조회
	 * @return
	 */
	@GetMapping("/chartCountUserByAge")
	@ResponseBody
	public List<UserCountDTO> countUserByAge() {
		return adminService.countUserByAge();
	}
	

	//**** 로그인 화면 및 메인화면 ****\\
	
	/**
	 * 관리자 메인 화면
	 * 
	 * @return
	 */
	@GetMapping("/main")
	public String mainPage() {
		return "admin/main";
	}
	
	
	
	

	/**
	 * 관리자 로그인 화면
	 * 
	 * @return
	 */
	@GetMapping("/sign-in")
	public String signInPage() {
		return "admin/signIn";
	}

	/**
	 * 관리자 로그인 기능
	 * 
	 * @param dto
	 * @param request
	 * @return
	 */
	@PostMapping("/sign-in")
	public String signInProc(HttpServletRequest request, SignInDTO signIndDTO, Admin admin) {

		String adminId = signIndDTO.getUserId();
		String adminPassword = signIndDTO.getUserPassword(); 
		
		// 유효성 검사
		if (!ValidationUtil.isValidateId(adminId)) {
			throw new DataDeliveryException(Define.SIGNUP_ID, HttpStatus.BAD_REQUEST);
		}
		if (adminPassword == null || adminPassword.trim().isEmpty()) {
			throw new DataDeliveryException(Define.SIGNIN_PWD, HttpStatus.BAD_REQUEST);
		}

		// 유효한 관리자인지 확인
		AdminDTO adminDTO = adminService.findAdminInfo(adminId);
		if(adminDTO == null) {
			throw new DataDeliveryException(Define.SIGNIN_ID, HttpStatus.BAD_REQUEST);
		}

		// 입력한 비밀번호와 DB의 비밀번호가 동일한지 확인
		admin = adminService.searchAdmin(adminId);
		if (admin != null) {
			boolean isMatch = passwordEncoder.matches(adminPassword, admin.getAdminPassword());
			if (!isMatch) {
				throw new DataDeliveryException(Define.SIGNIN_PWD_AGAIN, HttpStatus.BAD_REQUEST);
			}
		}
		// 세션 생성
		HttpSession session = request.getSession(true);
		session.setAttribute("admin", admin);

		return "redirect:/admin/main";
	}

	/**
	 * 관리자 비밀번호 변경 페이지
	 * 
	 * @return
	 */
	@GetMapping("/changePassword")
	public String changePasswordPage() {
		return "admin/changePassword";
	}

	/**
	 * 관리자 비밀번호 변경 로직
	 * 
	 * @param dto
	 * @return
	 */
	@PostMapping("/changePassword")
	public String changePasswordProc(ChangePasswordDTO dto, Admin admin) {

		String adminId = dto.getUserId();
		String newPassword = dto.getNewPassword();
		String checkPassword = dto.getCheckPassword();
		
		// 유효성 검사
		if (!ValidationUtil.isValidateId(adminId)) {
			throw new DataDeliveryException(Define.SIGNIN_ID, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidatePwdByAdmin(newPassword)) {
			throw new DataDeliveryException(Define.SIGNIN_PWD, HttpStatus.BAD_REQUEST);
		}
		if (!ValidationUtil.isValidatePwdByAdmin(checkPassword)) {
			throw new DataDeliveryException(Define.SIGNIN_PWD, HttpStatus.BAD_REQUEST);
		}

		// 유효한 관리자인지 확인
		AdminDTO adminDTO = adminService.findAdminInfo(dto.toAdmin().getAdminId());
		if (adminDTO == null) {
			throw new DataDeliveryException(Define.SIGNIN_ID, HttpStatus.BAD_REQUEST);
		}
		
		// 관리자 정보 조회
		admin = adminService.searchAdmin(adminId);
		if (!admin.getAdminId().equals(adminId)) {
			throw new DataDeliveryException(Define.SIGNIN_ID, HttpStatus.BAD_REQUEST);
		}
		if (!newPassword.equals(checkPassword)) {
			throw new DataDeliveryException(Define.PASSWORD_DISMATCH, HttpStatus.BAD_REQUEST);
		}

		// 현재 비밀번호와 새 비밀번호가 동일할 경우
		if (passwordEncoder.matches(newPassword, admin.getAdminPassword())) {
			throw new DataDeliveryException(Define.PASSWORD_MATCH_NOT_CHANGE, HttpStatus.BAD_REQUEST);
		}

		// 비밀번호 변경
		adminService.updatePassword(newPassword, adminId);
		return "redirect:/admin/main";
	}

	/**
	 * 관리자 로그아웃
	 * 
	 * @param param
	 * @return
	 */
	@GetMapping("/logout")
	public String logoutProc(Admin admin) {
		admin = (Admin) session.getAttribute("admin");
		session.invalidate();
		return "admin/signIn";
	}
	
	//**** 회원관리 페이지 ****\\
	
	/**
	 * 회원 관리 페이지
	 */
	@GetMapping("/userListPage")
	public String userManagePage() {
		return "admin/userList";
	}
	
	/**
	 * 회원 전체 정보 조회 및 검색 기능
	 * 페이징 처리
	 * @return
	 */
	@GetMapping("/userList")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> selectUserAllWithPay(
			@RequestParam(name = "searchType", defaultValue = "", required = false) String searchType,
			@RequestParam(name = "keyword", defaultValue = "", required = false) String keyword,
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size) {
		
		try {
			List<UserManagementDTO> userList;
			int totalCount;
			
			if(searchType != null && !searchType.isEmpty() && keyword != null && !keyword.isEmpty()) {
				userList = adminService.searchUser(searchType, keyword, page, size);
				totalCount = adminService.getSearchCount(searchType, keyword);
			} else {
				userList = adminService.selectUserAllWithPay(page, size);
				totalCount = adminService.countAllUsers();
			}
			
			int totalPages = (int) Math.ceil((double) totalCount / size);
			
			Map<String, Object> response = new HashMap<>();
			response.put("totalCount", totalCount);
			response.put("userList", userList);
			response.put("totalPages", totalPages);
			response.put("currentPage", page);
			response.put("pageSize", size);
			
			Admin admin = (Admin) session.getAttribute("admin");
			if(admin != null) {
				response.put("admin", admin);
			}
			
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace(); 
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}
	
	/**
	 * 회원 정보 상세보기 화면
	 * @return
	 */
	@GetMapping("/detailUserInfo")
	public String detailUserInfoPage(@RequestParam("id") Integer id, Model model) {
		User user = adminService.getDetailUserInfo(id);
		model.addAttribute("user",user);
		return "admin/detailUserInfo";
	}
	
	
	
	/**
	 * 회원 정보 수정 페이지
	 * @param id
	 * @param model
	 * @return
	 */
	@GetMapping("/updateUserInfo")
	public String updateUserInfoPage(@RequestParam("id") Integer id, Model model) {
		User user = adminService.getDetailUserInfo(id);
		model.addAttribute("user", user);
		return "admin/updateUserInfo"; 
	}
	
	/**
	 * 회원 정보 수정 기능
	 * @param user
	 * @param id
	 * @return
	 */
	@PostMapping("/updateUserInfo")
	public String updateUserInfoProc(User user, @RequestParam("id") Integer id) {
		
		// TODO - 유효성 검사
		
		adminService.updateUserInfo(user);
		return "admin/detailUserInfo";
	}
	

	/**
	 * 회원 정보 삭제
	 * @param id
	 * @return
	 */
	@GetMapping("/deleteUserInfo")
	public String deleteUserInfoProc(@RequestParam("id") Integer id) {
		adminService.withdrawUser(id);
		return "admin/userList";
	}
	
	/**
	 * 탈퇴 회원 조회 화면
	 * @return
	 */
	@GetMapping("/withdrawPage")
	public String withdrawPage() {
		return "admin/withdrawUserList";
	}
	
	
	/**
	 * 탈퇴 회원 정보 조회
	 * @param id
	 * @return
	 */
	@GetMapping("/withdrawUserInfo")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> selectWithdraw(
			@RequestParam(name = "searchType", defaultValue = "", required = false) String searchType,
			@RequestParam(name = "page", defaultValue = "1") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size) {
		
		try {
			List<WithdrawDTO> withdrawList;
			int totalCount;
		
		if(searchType != null && !searchType.isEmpty()) {
			withdrawList = adminService.searchReasonDetail(searchType, page, size);
			totalCount = adminService.countReasonDetail(searchType);
		} else {
			withdrawList = adminService.selectWithdraw(page, size);
			totalCount = adminService.getCountWithdraw();
		}
		
		int totalPages = (int) Math.ceil((double) totalCount/ size);
		Map<String, Object> response = new HashMap<>();
		response.put("totalCount", totalCount);
		response.put("withdrawList", withdrawList);
		response.put("totalPages", totalPages);
		response.put("currentPage", page);
		response.put("pageSize", size);
		
		Admin admin = (Admin) session.getAttribute("admin");
		if(admin != null) {
			response.put("admin", admin);
		}
		return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	/**
	 * 탈퇴 사유 및 개수 조회
	 * @return
	 */
	@GetMapping("/chartCountWithdrawReason")
	@ResponseBody
	public List<UserCountDTO> countWithdrawReason() {
		return adminService.countWithdrawReason();
	}
	
	/**
	 * 유저 -> 구독 해지자 수
	 * @author hj
	 * @return
	 */
	@GetMapping("/chartCountUnsubscribe")
	@ResponseBody
	public Integer countUnsubscribe() {
		return adminService.countUnsubscribe();
	}
	
	/**
	 * 유저 -> 전체 구독 결제 금액
	 * @author hj
	 * @return
	 */
	@GetMapping("/chartCountAllSubAmount")
	@ResponseBody
	public Integer countAllSubAmount() {
		return adminService.countAllSubAmount();
	}
	
	/**
	 * 구독자 -> 전체 환불 금액
	 * @author hj
	 * @return
	 */
	@GetMapping("/chartCountAllSubRefund")
	@ResponseBody
	public Integer countAllSubRefund() {
		return adminService.countAllSubRefund();
	}
	
}

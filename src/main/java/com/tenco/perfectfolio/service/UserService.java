package com.tenco.perfectfolio.service;

import com.tenco.perfectfolio.dto.*;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.interfaces.UserRepository;
import com.tenco.perfectfolio.repository.interfaces.analystic.JobNoticeRepository;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import com.tenco.perfectfolio.service.mongo.MongoUserService;
import com.tenco.perfectfolio.utils.Define;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
@RequiredArgsConstructor
public class UserService {

	@Autowired
	private final UserRepository userRepository;
	@Autowired
	private final PasswordEncoder passwordEncoder;
	@Autowired
	private MongoUserService mongoUserService;

	/**
	 * 회원 등록 서비스 기능 트랜잭션 처리
	 * 
	 * @param dto
	 */
	@Transactional
	public void createUser(SignUpDTO dto) {
		System.out.println("createUser 메소드 동작");
		int result = 0;

		try {
			// 비밀번호 암호화 후 DB에 insert
			String hashPwd = passwordEncoder.encode(dto.getUserPassword());
			dto.setUserPassword(hashPwd);

			result = userRepository.insert(dto.toUser());
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	/**
	 * 서버 운영체제에 파일 업로드 기능 MultipartFile getOriginalFilename : 사용자가 작성한 파일명
	 * uploadFileName : 서버 컴퓨터에 저장될 파일명
	 * 
	 * @return
	 */
	private String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > Define.MAX_FILE_SIZE) {
			throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.", HttpStatus.BAD_REQUEST);
		}

		// 서버 컴퓨터에 파일을 넣을 디렉토리가 있는지 검사
		String saveDirectory = Define.UPLOAD_FILE_DERECTORY;
		File directory = new File(saveDirectory);
		if (!directory.exists()) {
			directory.mkdirs();
		}

		// 파일 이름 생성(중복 이름 예방)
		String uploadFileName = UUID.randomUUID() + "_" + mFile.getOriginalFilename();
		// 파일 전체경로 + 새로생성한 파일명
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		System.out.println("업로드 경로 : " + uploadPath);
		File destination = new File(uploadPath);

		// 예외처리
		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new DataDeliveryException("파일 업로드중에 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { mFile.getOriginalFilename(), uploadFileName };
	}

	@Transactional
	public int checkDuplicateID(String userId) {
		int result = 0;
		result = userRepository.checkDuplicateID(userId);

		if (result != 0) {
			return 1;
		}

		return 0;
	}

	@Transactional
	public void changPassword(String newPassword, String userId) {
		userRepository.changePassword(newPassword, userId);

	}

	@Transactional
	public int checkDuplicateEmail(String email) {
		int result = 0;
		result = userRepository.checkDuplicateEmail(email);
		if (result != 0) {
			return 1;
		}
		return 0;
	}

	/**
	 * 
	 * userEmail로 사용자 존재 여부 조회
	 * 
	 * @param = String userEmail
	 * @return User
	 */
	public PrincipalDTO searchUserEmail(String userEmail) {
		User user = userRepository.findByUserEmail(userEmail);
		System.out.println("유저 서비스::: 사용자???:" + user);

		if (user != null) {
			PrincipalDTO principalDTO = PrincipalDTO.builder().id(user.getId()).userId(user.getUserId())
					.username(user.getUsername()).userSocialType(user.getSocialType()).build();
			return principalDTO;
		}

		return null;
	}

	/**
	 * userId로 사용자 존재 여부 조회
	 * 
	 * @param userId
	 * @return
	 */
	public PrincipalDTO searchUserId(String userId) {
		User user = userRepository.findByUserId(userId);
		if (user != null) {
			String subscribing = (user.getSubscribing() != null) ? user.getSubscribing() : "default";

			PrincipalDTO principalDTO = PrincipalDTO.builder()
					.id(user.getId())
					.userId(user.getUserId())
					.username(user.getUsername())
					.userSocialType(user.getSocialType())
					.subscribing(subscribing) // null인 경우 처리
					.orderName(user.getOrderName())
					.build();

			return principalDTO;
		}
		return null;
	}

	/**
	 * userId로 사용자 정보 조회
	 * 
	 * @param userId
	 * @return
	 */
	public User searchUserIdByUser(String userId) {
		User user = userRepository.findByUserId(userId);
		if (user != null) {
			return user;
		}
		return null;
	}

	/**
	 * id(PK)로 사용자 전체 조회
	 * 
	 * @param id
	 * @return
	 */
	public User searchById(Integer id) {
		User user = userRepository.findByid(id);
		if (user != null) {
			return user;
		}
		return null;
	}

	public List<User> findAll() {
		return userRepository.findAll();
	}

	/**
	 * 회원탈퇴 - 탈퇴 테이블에 정보 입력 후 기존 유저 테이블에서 정보 삭제
	 * 
	 * @param principalDTO - 세션에 저장된 유저 정보
	 * @param withdrawDTO  - 탈퇴 사유 폼
	 */
	@Transactional
	public void withdrawUser(PrincipalDTO principalDTO, WithdrawDTO withdrawDTO) {

		// 사용자 정보를 가져옴
		User user = userRepository.findByid(principalDTO.getId());
		
		if (withdrawDTO.getReason() != null && !withdrawDTO.getReason().isEmpty()) {
			// 기존 유저 정보를 withdraw 테이블에 삽입
			userRepository.insertWithdraw(user);

			// 탈퇴 사유를 withdraw_reason_tb에 삽입
			userRepository.insertWithdrawReason(user.getUserId(), withdrawDTO.getReason(),
					withdrawDTO.getReasonDetail());

			// 사용자 정보를 삭제
			userRepository.delete(user.getId());

		} else {
			throw new DataDeliveryException(Define.WITHDRAW_REASON_SELECT, HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 3년이 지난 탈퇴 회원 삭제
	 */
	public void deleteOldWithdraw() {
		userRepository.deleteOldWithdraw();
	}

	/**
	 * User(Local) 수정
	 * @param updateUserDTO
	 */
	@Transactional
	public void updateUserInfo(UpdateUserDTO updateUserDTO) {
		User user = User.builder()
				.id(updateUserDTO.getId())
				.username(updateUserDTO.getUsername())
				.userNickname(updateUserDTO.getNickName())
				.userEmail(updateUserDTO.getEmail())
				.userTel(updateUserDTO.getTel())
				.build();
		userRepository.updateUserInfo(user);
	}

	@Transactional
	public List<Map<String, Object>> getUserSkillList(int id) {
		List<Map<String, Object>> userSkillList = new ArrayList<>();

		// 사용자 ID로 MongoUserModel 객체를 가져와버리기~
		MongoUserModel mongoUserModel = mongoUserService.findByUserId(id);

		// MongoUserModel의 userSkill 데이터를 Map 형식으로 변환해버리기~
		if (mongoUserModel != null && mongoUserModel.getUserSkill() != null) {
			MongoUserModel.UserSkill userSkill = mongoUserModel.getUserSkill();

			// 각 카테고리를 HashMap으로 변환해서 List에 추가해버리기~
			Map<String, Object> languageMap = new HashMap<>();
			languageMap.put("Language", userSkill.getLanguage());
			userSkillList.add(languageMap);

			Map<String, Object> frameworkMap = new HashMap<>();
			frameworkMap.put("Framework", userSkill.getFramework());
			userSkillList.add(frameworkMap);

			Map<String, Object> sqlMap = new HashMap<>();
			sqlMap.put("SQL", userSkill.getSQL());
			userSkillList.add(sqlMap);

			Map<String, Object> noSqlMap = new HashMap<>();
			noSqlMap.put("NoSQL", userSkill.getNoSQL());
			userSkillList.add(noSqlMap);

			Map<String, Object> devOpsMap = new HashMap<>();
			devOpsMap.put("DevOps", userSkill.getDevOps());
			userSkillList.add(devOpsMap);

			Map<String, Object> serviceMap = new HashMap<>();
			serviceMap.put("Service", userSkill.getService());
			userSkillList.add(serviceMap);

			Map<String, Object> qualificationMap = new HashMap<>();
			qualificationMap.put("Qualification", mongoUserModel.getQualification());
			userSkillList.add(qualificationMap);

			Map<String, Object> linguisticMap = new HashMap<>();
			linguisticMap.put("Linguistic", mongoUserModel.getLinguistics());
			userSkillList.add(linguisticMap);
		}else {
			Map<String, Object> languageMap = new HashMap<>();
			languageMap.put("Language", null);
			userSkillList.add(languageMap);

			Map<String, Object> frameworkMap = new HashMap<>();
			frameworkMap.put("Framework", null);
			userSkillList.add(frameworkMap);

			Map<String, Object> sqlMap = new HashMap<>();
			sqlMap.put("SQL", null);
			userSkillList.add(sqlMap);

			Map<String, Object> noSqlMap = new HashMap<>();
			noSqlMap.put("NoSQL",null);
			userSkillList.add(noSqlMap);

			Map<String, Object> devOpsMap = new HashMap<>();
			devOpsMap.put("DevOps", null);
			userSkillList.add(devOpsMap);

			Map<String, Object> serviceMap = new HashMap<>();
			serviceMap.put("Service",null);
			userSkillList.add(serviceMap);

			Map<String, Object> qualificationMap = new HashMap<>();
			qualificationMap.put("Qualification", null);
			userSkillList.add(qualificationMap);

			Map<String, Object> linguisticMap = new HashMap<>();
			linguisticMap.put("Linguistic", null);
			userSkillList.add(linguisticMap);
		}

		return userSkillList;
	}

	public List<CountResultDTO> getTodayCountResult() {
		return userRepository.getCountResults();
	}

}
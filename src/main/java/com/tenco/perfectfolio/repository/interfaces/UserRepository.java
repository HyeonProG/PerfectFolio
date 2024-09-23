package com.tenco.perfectfolio.repository.interfaces;

import com.tenco.perfectfolio.dto.CountResultDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.repository.model.User;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserRepository {

	public int insert(User user); 
	public User findByUserEmail(String userEmail);
	public User findByUserId(String userId);
	
	public User findByid(int id);
	public List<User> findAll();
	public int insertWithdraw(User user); 
	public int insertWithdrawReason(@Param("userId") String userId, @Param("reason") String reason, @Param("reasonDetail") String reasonDetail);
	public void delete(int id);
	public void deleteOldWithdraw();

	public int checkDuplicateID(String userId);
	public int checkDuplicateEmail(String email);
	public void changePassword(String newPassword, String userId);

	public void updateUserInfo(User user);
	public List<Map<String, Object>> getUserSkillList(int id);

	public List<CountResultDTO> getCountResults();
}

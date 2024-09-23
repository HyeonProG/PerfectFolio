package com.tenco.perfectfolio.repository.interfaces;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tenco.perfectfolio.dto.payment.PaymentListDTO;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.repository.model.payment.Order;
import com.tenco.perfectfolio.repository.model.payment.Payment;
import com.tenco.perfectfolio.repository.model.payment.Refund;
import com.tenco.perfectfolio.repository.model.payment.Subscribing;

@Mapper
public interface PaymentRepository {

	public List<Subscribing> selectAllCustomers();

	public int insertOrder(Order order);
	public int insert(Payment payment);
	public int insertRefund(Refund refund);

	public int update(int payPk);

	public Subscribing checkUserPayInfo(int userPk);
	public List<PaymentListDTO> getAllPayList(@Param("size") int size, @Param("offset") int offset);
	public User getPayUserInfo(Integer userId);

	public int checkDuplication(int userPk);
	public int getPayListCounts();

	public List<Refund> getAllRefundList(@Param("size") Integer size, @Param("offset") int offset);
	public int getRefundListCounts();

	public List<PaymentListDTO> getPayListsWithContents(@Param("searchContents") String searchContents,@Param("size") int size, @Param("offset") int offset);
	public int getPayCountsWithContents(String searchContents);

	public List<Refund> searchAllRefundList(@Param("searchRange") String searchRange, @Param("searchContents") String searchContents, @Param("size") Integer size, @Param("offset") int offset);
	public List<Refund> searchRefundListOnlyRange(@Param("searchRange") String searchRange, @Param("size") Integer size, @Param("offset") int offset);

	public int getAllRefundCounts(@Param("searchRange") String searchRange, @Param("searchContents") String searchContents);
	public int getRefundCountsWithContents(String searchContents);

	// 정기 결제
	public void insertSubscribing(Subscribing subscribing);
	public void updateSubscribing(Date toDay, String nextDate);

	// 구독해지
	public int insertTerminReason(@Param("cancelReason") String cancelReason,@Param("userPk") Integer userPk);
	public int updateStopSubscribe(Integer userPk);
	
	// 구독 유지 중인 구독자 수 
	public int countSubscribing();
	
}

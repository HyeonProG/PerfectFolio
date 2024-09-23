package com.tenco.perfectfolio.schedule;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tenco.perfectfolio.dto.payment.PaymentDTO;
import com.tenco.perfectfolio.repository.interfaces.PaymentRepository;
import com.tenco.perfectfolio.repository.model.payment.Subscribing;
import com.tenco.perfectfolio.service.PaymentService;

@Component
public class PaymentScheduler {

	@Autowired
	private PaymentRepository paymentRepository;
	@Autowired
	private PaymentService paymentService;

	// @Scheduled(cron = "0 0 0 1 * *") // 매달 1일 자정에 실행
	public void runMonthlyPayment() {
		
		Date toDay = new Date();
		
		// 매일 오후 3시에 자동결제 실시
		if(toDay.getHours() == 15) {
			// DB에서 모든 사용자 정보를 가져옴
			List<Subscribing> payments = paymentRepository.selectAllCustomers();
			
			// 다음 결제일과 오늘 날짜가 일치하는지 판단
			String dateFormatType = "yyyy-MM-dd";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatType);
			String nextDate = simpleDateFormat.format(toDay);
			
			try {
				for (Subscribing subscribing : payments) {
					if(subscribing.getNextPay().equals(nextDate)) {
						String orderId = UUID.randomUUID().toString();
						paymentService.authorizeBillingAndAutoPayment(subscribing.getCustomerKey(), subscribing.getBillingKey(),
								subscribing.getUserId(), orderId, subscribing.getOrderName(), subscribing.getAmount(), // 결제 금액
								subscribing.getNextPay());
					}
				}
			} catch (Exception e) {
				System.err.println("결제 실패: " + e.getMessage());
			}
			
		}
		

//        for (PaymentDTO payment : payments) {
//            try {
//                // 각 사용자의 자동 결제를 수행
//                String orderId = UUID.randomUUID().toString();
//
//                paymentService.authorizeBillingAndAutoPayment(
//                        payment.getCustomerKey(),
//                        payment.getBillingKey(),
//                        payment.getUserId(),
//                        orderId,
//                        payment.getOrderName(),
//                        payment.getAmount() // 결제 금액
//                );
//            } catch (Exception e) {
//                System.err.println("결제 실패: " + e.getMessage());
//            }
//        }

	}
}

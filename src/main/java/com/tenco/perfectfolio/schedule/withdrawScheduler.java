package com.tenco.perfectfolio.schedule;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tenco.perfectfolio.service.UserService;

@Component
public class withdrawScheduler {

	@Autowired
	private UserService userService;

	private LocalDate lastExecutionDate = LocalDate.now().minusYears(3);

	@Scheduled(cron = "0 0 4 * * *") // 새벽 4시 마다 실행
	public void performWithdraw() {
		LocalDate today = LocalDate.now();
		// 3년이 된 데이터는 삭제
		if (ChronoUnit.YEARS.between(lastExecutionDate, today) >= 3) {
			lastExecutionDate = today;
			userService.deleteOldWithdraw();
		}
	}

}

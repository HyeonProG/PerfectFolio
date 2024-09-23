package com.tenco.perfectfolio.utils;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

public abstract class ValueFormatter {

	// 시간 포맷
	public String timestampToString(String string) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(string);
	}

	public String formatKoreanWon(Long amount) {
		DecimalFormat df = new DecimalFormat("#,###,###");
		String formatNumber = df.format(amount);
		return formatNumber + "원";
	}
}

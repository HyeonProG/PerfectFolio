package com.tenco.perfectfolio.utils;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class ValidationUtil {

	// 유효한 이름인지 확인
	public static boolean isValidateName(String str) {
		return isNotOnlyWhitespace(str) && // 공백만 이루어져 있지 않고
				isLessThanOrEqual(str, 10) && // 최소 10글자 이하
				isNotContainsWhitespace(str) && // 공백을 포함하지 않음
				isOnlyKorean(str) || // 한글
				isOnlyEnglish(str); // 영어
	}
	// 유효한 아이디인지 확인
	public static boolean isValidateId(String str) {
		return  isOnlyEnglish(str) && // 영어
				isNotOnlyWhitespace(str) && // 공백만 이루어져 있지 않고
				isNotContainsWhitespace(str); // 공백을 포함하지 않음
	}

	// 유효한 비밀번호인지 확인
	public static boolean isValidatePwd(String str) {
		return isNotOnlyWhitespace(str) && // 공백만 이루어져 있지 않고
				isNotContainsWhitespace(str) && // 공백을 포함하지 않고
				isLessThanOrEqual(str, 20) && // 최대 20글자 이하
				isMoreThanOrEqual(str, 8) && // 최소 8글자 이상
				isOnlyEnglish(str) &&
				isOnlyNumber(str) &&
				isSpec(str);
	}
	
	// 유효한 비밀번호인지 확인
	public static boolean isValidatePwdByAdmin(String str) {
		return isNotOnlyWhitespace(str) && // 공백만 이루어져 있지 않고
				isNotContainsWhitespace(str) && // 공백을 포함하지 않고
				isLessThanOrEqual(str, 20) && // 최대 20글자 이하
				isMoreThanOrEqual(str, 5) && // 최소 5글자 이상
				isOnlyEnglish(str) ||
				isOnlyNumber(str) ||
				isSpec(str);
	}

	// 유효한 전화번호인지 확인
	public static boolean isValidateTel(String str) {
		return isTel(str) && // 전화번호 형식
				isOnlyNumber(str) && // 숫자
				isNotOnlyWhitespace(str) && // 공백만 이루어져 있지 않고
				isNotContainsWhitespace(str) && // 공백을 포함하지 않고
				isLessThanOrEqual(str, 13) && // 최대 13글자 이하
				isMoreThanOrEqual(str, 12); // 최소 12글자 이상
	}
	
	// 유효한 별명인지 확인
	public static boolean isValidateNick(String str) {
		return isNotOnlyWhitespace(str) &&
				isNotContainsWhitespace(str);
	}
	
	// 유효한 이메일인지 확인
	public static boolean isValidateEmail(String str) {
		return isEmail(str) &&
			isNotOnlyWhitespace(str) &&
			isNotContainsWhitespace(str);
	}
	
	

	// 입력된 날짜가 오늘 이전인지 확인
	public static boolean isDateBeforeToday(String dateStr) {
		try {
			LocalDate date = LocalDate.parse(dateStr);
			LocalDate today = LocalDate.now();
			return date.isBefore(today);
		} catch (DateTimeParseException e) {
			// 날짜 형식이 잘못된 경우 false 반환
			return false;
		}
	}

	// 문자열에 공백이 포함되어 있지 않은지 검사
	public static boolean isNotContainsWhitespace(String str) {
		return str != null && !str.contains(" ");
	}

	// 문자열이 공백으로만 이루어져 있지 않은지 검사
	public static boolean isNotOnlyWhitespace(String str) {
		return str != null && !str.trim().isEmpty();
	}

	// 문자열이 한글로만 이루어져 있는지 검사
	public static boolean isOnlyKorean(String str) {
		return str != null && Pattern.matches("^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+$", str);
	}

	// 문자열이 영어로만 이루어져 있는지 검사
	public static boolean isOnlyEnglish(String str) {
//		return str != null && Pattern.matches("^[a-zA-Z]+$", str);
		return str != null && Pattern.compile("[a-zA-Z]").matcher(str).find();
	}

	// 숫자로만 이루어져 있는지 검사
	public static boolean isOnlyNumber(String str) {
//		return str != null && Pattern.matches("^[0-9]+$", str);
		return str != null && Pattern.compile("[0-9]").matcher(str).find();
	}

	// 문자열이 이메일 형식으로 이루어져 있는지 검사
	public static boolean isEmail(String str) {
		return str != null && Pattern.matches("^[a-zA-Z0-9_+&*-]+@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,10}$", str);
		// 2글자에서 10글자 사이
	}

	// 문자열이 전화번호 형식인지 검사
	public static boolean isTel(String str) {
		return str != null && Pattern.matches("^\\d{3}-\\d{3,4}-\\d{4}$", str);
	}
	
	// 특수문자 포함되어 있는지 검사
	public static boolean isSpec(String str) {
//		return str != null && Pattern.matches("^[~!@#$%^&*()_+|<>?:{}]+$", str);
		return str != null && Pattern.compile("[!@#$%^&*]").matcher(str).find();
	}

	// 문자열 길이가 주어진 정수 이하 인지 검사
	public static boolean isLessThanOrEqual(String str, int length) {
		return str != null && str.length() <= length;
	}

	// 문자열 길이가 주어진 정수 이상 인지 검사
	public static boolean isMoreThanOrEqual(String str, int length) {
		return str != null && str.length() >= length;
	}

}

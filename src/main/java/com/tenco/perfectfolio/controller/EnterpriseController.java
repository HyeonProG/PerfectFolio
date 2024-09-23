package com.tenco.perfectfolio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/enterprise")
@RequiredArgsConstructor
public class EnterpriseController {

	/**
	 * 기업 전용 회원가입 페이지 요청
	 * @return
	 */
	@GetMapping("/sign-up")
	public String getMethodName() {
		return "company/signUp";
	}
	
}

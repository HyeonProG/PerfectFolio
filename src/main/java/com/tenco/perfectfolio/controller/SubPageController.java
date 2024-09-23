package com.tenco.perfectfolio.controller;

import com.tenco.perfectfolio.repository.model.analystic.TrendModel;
import com.tenco.perfectfolio.service.mongo.TrendSkillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
public class SubPageController {

	@Autowired
	private TrendSkillService trendSkillService;

	/**
	 * About > 소개 페이지 요청
	 * @return
	 */
	@GetMapping("/introduction")
	public String getIntroductionPage() {
		return "subPage/aboutUS";
	}
	
	/**
	 * Trend > 트랜드 페이지 요청
	 * @return
	 */
	@GetMapping("/trend")
	public String getMethodName() {
		return "subPage/trend";
	}
	
	
}

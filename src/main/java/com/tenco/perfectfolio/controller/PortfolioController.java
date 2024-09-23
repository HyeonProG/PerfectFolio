package com.tenco.perfectfolio.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenco.perfectfolio.repository.interfaces.UserRepository;
import com.tenco.perfectfolio.repository.model.User;
import com.tenco.perfectfolio.utils.Define;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.tenco.perfectfolio.dto.PortfolioDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.model.Portfolio;
import com.tenco.perfectfolio.service.PortfolioService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portfolio")
public class PortfolioController {

	@Autowired
	private final PortfolioService portfolioService;
	@Autowired
	private UserRepository userRepository;

	/**
	 * 유저 마이페이지 > 포트폴리오 업로드 로직 처리
	 * 
	 * @param dto
	 * @return user/my-portfolio.jsp
	 */
	@PostMapping("/upload")
	public String postMethodName(PortfolioDTO dto) {
		if (dto.getMFile() == null || dto.getMFile().isEmpty()) {
			throw new DataDeliveryException("파일을 업로드 해주세요.", HttpStatus.BAD_REQUEST);
		}
		if (dto.getUserId() == null || dto.getUserId().equals("")) {
			throw new DataDeliveryException("로그인 먼저 해주세요.", HttpStatus.BAD_REQUEST);
		}

		Portfolio portfolio = portfolioService.getMyPortfolio(dto.getUserId());
		
		if(portfolio != null) {
			dto.setStatus(Define.STATUS_WAIT);
			portfolioService.updatePortfolio(dto);
		}else {
			portfolioService.createPortfolio(dto);
		}
		
		return "redirect:/user/my-portfolio";
	}

	/**
	 * 포트폴리오 다운로드 로직 처리
	 * 
	 * @return
	 */
	@GetMapping("/download/{uploadFileName}")
	public ResponseEntity<Resource> getMethodName(@PathVariable(name ="uploadFileName") String uploadFileName,HttpServletResponse response) {
		try {
			// 다운로드 받을 파일 정보 읽기
			String fileFullPath = System.getProperty("user.dir") + "/src/main/resources/static/portfolio/" + uploadFileName;
			File file = new File(fileFullPath);
			FileInputStream fis = new FileInputStream(fileFullPath);
			// Edge, Chorme 한글 인코딩
			fileFullPath = new String(fileFullPath.getBytes("UTF-8"), "8859_1");
			
			// 응답 설정
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=" + uploadFileName);
			OutputStream os = response.getOutputStream();
			
			// 응답
			int length;
			byte[] b = new byte[(int) file.length()];
			while ((length = fis.read(b)) > 0) {
				os.write(b, 0, length);
			}

			os.flush();

			os.close();
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 미리보기
	 * @param uploadFileName
	 * @param request
	 * @return
	 */
	@GetMapping("/preview/{uploadFileName}")
	public String getMethodName(@PathVariable(name ="uploadFileName") String uploadFileName,HttpServletRequest request) {
		String fileFullPath = "/portfolio/"+uploadFileName;
		request.setAttribute("fileFullPath", fileFullPath);
		return "user/myPage/preview";
	}

	@GetMapping("/working")
	public String getPortfolio(Model model) {
		List<Portfolio> portfolioWaitList = portfolioService.getPortfolioWaitList();
		Map<Integer, String> userNameMap = new HashMap<Integer, String>();
		for (Portfolio portfolio : portfolioWaitList) {
			User user = userRepository.findByid(portfolio.getUserId());
			userNameMap.put(portfolio.getUserId(), user.getUsername());
		}

		model.addAttribute("portfolioWaitList", portfolioWaitList);
		model.addAttribute("userNameMap", userNameMap);
		return "admin/adminPortfolio";
	}

	@PostMapping("/approve")
	public String approvePortfolio(@RequestParam("portfolioId") Integer userPk) {
		portfolioService.portfolioApproval(userPk);
		return "redirect:/portfolio/working";
	}

	@PostMapping("/reject")
	public String rejectPortfolio(@RequestParam("portfolioId") Integer userPk) {
		portfolioService.portfolioCompanion(userPk);
		return "redirect:/portfolio/working";
	}

}
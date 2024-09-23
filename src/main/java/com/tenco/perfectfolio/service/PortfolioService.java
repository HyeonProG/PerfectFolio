package com.tenco.perfectfolio.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tenco.perfectfolio.dto.PortfolioDTO;
import com.tenco.perfectfolio.handler.exception.DataDeliveryException;
import com.tenco.perfectfolio.repository.interfaces.PortfolioRepository;
import com.tenco.perfectfolio.repository.model.Portfolio;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PortfolioService {

	@Autowired
	private final PortfolioRepository portfolioRepository;

	/**
	 * 유저 포트폴리오 내역 확인
	 * @param userPk
	 * @return
	 */
	public Portfolio getMyPortfolio(int userPk) {
		Portfolio portfolio = portfolioRepository.getMyPortfolio(userPk);
		return portfolio;
	};

	public Portfolio getMyPortfolioApproval(int userPk) {
		Portfolio portfolio = portfolioRepository.getMyPortfolioApproval(userPk);
		return portfolio;
	};

	/**
	 * 포트폴리오 업로드 로직 처리
	 */
	@Transactional
	public void createPortfolio(PortfolioDTO dto) {
		int result = 0;

		if (dto.getMFile() != null && !dto.getMFile().isEmpty()) {
			String[] fileNames = uploadFile(dto.getMFile());
			dto.setOriginFileName(fileNames[0]);
			dto.setUploadFileName(fileNames[1]);
		}
		
		result = portfolioRepository.insert(dto);
		
		if (result != 1) {
			throw new DataDeliveryException("파일 업로드 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 포트폴리오 업데이트 로직 처리
	 * @param dto
	 */
	public void updatePortfolio(PortfolioDTO dto) {
		int result = 0;

		if (dto.getMFile() != null && !dto.getMFile().isEmpty()) {
			String[] fileNames = uploadFile(dto.getMFile());
			dto.setOriginFileName(fileNames[0]);
			dto.setUploadFileName(fileNames[1]);
		}
		
		result = portfolioRepository.update(dto);
		
		if (result != 1) {
			throw new DataDeliveryException("파일 업로드 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 파일 업로드
	 */
	@Transactional
	public String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > 1024 * 1024 * 20) {
			throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.", HttpStatus.BAD_REQUEST);
		}

		String saveDirectory = System.getProperty("user.dir") + "/src/main/resources/static/portfolio/";
		String originalFileName = mFile.getOriginalFilename();
		String uploadFileName = UUID.randomUUID() + "_" + originalFileName;
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		File destination = new File(uploadPath);

		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new DataDeliveryException("파일 업로드 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { originalFileName, uploadFileName };
	}

	public List<Portfolio> getPortfolioWaitList() {
		return portfolioRepository.getMyPortfolioWait();
	}

	public void portfolioApproval(int userPk) {
		portfolioRepository.updatePortfolioApproval(userPk);
	}

	public void portfolioCompanion(int userPk) {
		portfolioRepository.updatePortfolioCompanion(userPk);
	}

}

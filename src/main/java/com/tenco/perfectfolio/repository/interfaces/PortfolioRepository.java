package com.tenco.perfectfolio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.tenco.perfectfolio.dto.PortfolioDTO;
import com.tenco.perfectfolio.repository.model.Portfolio;

import java.util.List;

@Mapper
public interface PortfolioRepository {

	public int insert(PortfolioDTO dto);

	public Portfolio getMyPortfolio(int userPk);

	public Portfolio getMyPortfolioApproval(int userPk);

	public List<Portfolio> getMyPortfolioWait();

	public String getMyPortfolioStatus(int userPk);

	public void updatePortfolioApproval(int userPk);

	public void updatePortfolioCompanion(int userPk);

	public int update(PortfolioDTO dto);

}

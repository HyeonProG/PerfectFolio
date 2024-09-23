package com.tenco.perfectfolio.repository.interfaces;

import com.tenco.perfectfolio.dto.CompanyPaymentDTO;
import com.tenco.perfectfolio.dto.ProposalDTO;
import com.tenco.perfectfolio.dto.company.PayHistory;
import com.tenco.perfectfolio.repository.model.company.Bookmark;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CompanyRepository{

	List<String> getCategories();
	
	List<Bookmark> getBookmarkList();
	
    // 결제 신청
    public int insertPayment(CompanyPaymentDTO companyPaymentDTO);

    // 결제 아이템 있는 지 조회
    public int getGoodsByComId(Integer comId);

    // 결제 아이템 신규 저장
    public void insertGoods(@Param("comId")Integer comId, @Param("goodsEach")Integer goodsEach);

    // 결제 아이템 수량 확인
    public int selectGoods(Integer comId);

    // 결제 아이템 사용
    public void updateGoodsMinus(Integer comId);

    // 결제 아이템 추가
    public void updateGoodsAdd(@Param("comId")Integer comId, @Param("goodsEach")Integer goodsEach);

    public List<PayHistory> selectPayHistory(@Param("comId")Integer comId);

    public List<ProposalDTO> selectProposal(@Param("comId")Integer comId);
}

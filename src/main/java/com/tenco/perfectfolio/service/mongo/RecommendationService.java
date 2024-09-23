package com.tenco.perfectfolio.service.mongo;

import com.tenco.perfectfolio.repository.interfaces.analystic.RecommendationMapper;
import com.tenco.perfectfolio.repository.model.analystic.RecommendationCountModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class RecommendationService {

    @Autowired
    private RecommendationMapper recommendationMapper;

    // 유저별 recommendation 카운트를 조회하는 메서드
    public List<RecommendationCountModel> countRecommendations(LocalDate date) {
        // 오늘 날짜를 문자열로 변환
        String recommendedDate = date.toString();
        return recommendationMapper.countRecommendationsByDate(recommendedDate);
    }
}

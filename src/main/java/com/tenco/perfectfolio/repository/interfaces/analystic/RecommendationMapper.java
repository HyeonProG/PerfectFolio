package com.tenco.perfectfolio.repository.interfaces.analystic;

import com.tenco.perfectfolio.repository.model.analystic.RecommendationCountModel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface RecommendationMapper {
    List<RecommendationCountModel> countRecommendationsByDate(@Param("recommendedDate") String recommendedDate);
}
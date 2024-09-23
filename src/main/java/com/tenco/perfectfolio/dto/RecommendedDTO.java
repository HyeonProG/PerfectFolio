package com.tenco.perfectfolio.dto;

import com.tenco.perfectfolio.repository.model.RecommendCompanies;
import lombok.*;

import java.sql.Date;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class RecommendedDTO {

    private int id;
    private int boardId;
    private String userId;
    private double similarity;
    private Date recommended_date;

    public RecommendCompanies toRecommendCompanies() {
        return RecommendCompanies.builder()
                .id(this.id)
                .boardId(this.boardId)
                .userId(this.userId)
                .similarity(this.similarity)
                .recommendedDate(this.recommended_date)
                .build();
    }

}

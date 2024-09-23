package com.tenco.perfectfolio.repository.model.analystic;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class RecommendationCountModel {
    private int userId;
    private String userEmail;
    private String userName;
    private int recommendationCount;
}

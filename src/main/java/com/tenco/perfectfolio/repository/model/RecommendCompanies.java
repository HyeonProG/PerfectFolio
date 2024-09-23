package com.tenco.perfectfolio.repository.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class RecommendCompanies {

    private int id;
    private String title;
    private String companyName;
    private String jobUrl;
    private String site;
    private String userId;
    private int limit;
    private double similarity;
    private Date recommendedDate;
    private int boardId;

}

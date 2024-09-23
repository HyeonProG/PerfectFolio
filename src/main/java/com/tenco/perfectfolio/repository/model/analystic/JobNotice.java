package com.tenco.perfectfolio.repository.model.analystic;

import lombok.*;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString

public class JobNotice {

    private int id;
    private String title;
    private String jobUrl;
    private String companyName;
    private String experience;
    private String endDate;
    private String site;

}

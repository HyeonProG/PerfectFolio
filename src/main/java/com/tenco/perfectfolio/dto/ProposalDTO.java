package com.tenco.perfectfolio.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProposalDTO {

    private String userName;

    private String userEmail;

    private String userGender;

    private String userTel;

    private LocalDateTime proposalDate;

    private String status;

    public  String formatLocalDateTime() {
        // 원하는 형식 지정, 예: "yyyy년 MM월 dd일 HH:mm:ss"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm:ss");
        return proposalDate.format(formatter);
    }

}

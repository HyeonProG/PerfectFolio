package com.tenco.perfectfolio.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class AddGoogleInfoDTO {

    private String userGender;
    private String userBirth;
    private String userTel;
    private String userNickname;
}
package com.tenco.perfectfolio.dto.admin;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminUserInfoDTO {

    private int id;
    private String username;
    private String userNickname;
    private String createdAt;
    private String userSocialType;
    

}

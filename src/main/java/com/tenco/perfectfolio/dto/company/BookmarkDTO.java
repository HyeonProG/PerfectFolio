package com.tenco.perfectfolio.dto.company;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookmarkDTO {
    // user_tb 의 PK 입니다
    private String userId;

    // user_tb 의 user_name 입니다
    private String userName;



}

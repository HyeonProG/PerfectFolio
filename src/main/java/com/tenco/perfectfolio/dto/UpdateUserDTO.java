package com.tenco.perfectfolio.dto;

import com.tenco.perfectfolio.repository.model.User;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class UpdateUserDTO {
    private int id;
    private String username;
    private String nickName;
    private String email;
    private String tel;

}

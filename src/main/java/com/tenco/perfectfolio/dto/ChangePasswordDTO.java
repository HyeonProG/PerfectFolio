package com.tenco.perfectfolio.dto;

import com.tenco.perfectfolio.repository.model.admin.Admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChangePasswordDTO {
    private String userId;
    private String newPassword;
    private String checkPassword;

    public Admin toAdmin() {
    	return Admin.builder()
    			.adminId(this.userId)
    			.adminPassword(this.newPassword)
    			.build();
    }
    
}

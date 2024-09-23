package com.tenco.perfectfolio.dto;

import lombok.*;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class CompanyGoodsDTO {

    Integer id;
    Integer comId;
    Integer goodsNum;
    Timestamp usedDate;
}

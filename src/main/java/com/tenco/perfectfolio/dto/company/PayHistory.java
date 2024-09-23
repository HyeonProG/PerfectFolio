package com.tenco.perfectfolio.dto.company;

import lombok.*;
import org.checkerframework.common.aliasing.qual.NonLeaked;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PayHistory {

    private Integer id;
    private Integer userId;
    private String goodsName;
    private Integer goodsPrice;
    private LocalDateTime paymentDate;

    public String formatLocalDateTime() {
        // 원하는 형식 지정, 예: "yyyy년 MM월 dd일 HH:mm:ss"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm:ss");
        return paymentDate.format(formatter);
    }

}

package com.tenco.perfectfolio.dto.company;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class SimilarityListDTO {

    private int id;
    private String userName;
    private double similarity;

}

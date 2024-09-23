package com.tenco.perfectfolio.repository.model.analystic;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TrendModel {
    private String skillname;
    private int count;
    private int requirecount;

}

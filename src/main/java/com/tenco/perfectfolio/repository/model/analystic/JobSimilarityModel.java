package com.tenco.perfectfolio.repository.model.analystic;

import lombok.Data;
import lombok.ToString;
import org.bson.types.ObjectId;

import java.util.Map;

@Data
@ToString
public class JobSimilarityModel {

    private ObjectId _id;
    private Integer userId;
    private Integer boardId;
    private Map<String, Map<String, Integer>> qualificationsSkill;
    private Double similarityScore;

}

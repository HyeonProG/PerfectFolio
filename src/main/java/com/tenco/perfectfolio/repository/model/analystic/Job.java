package com.tenco.perfectfolio.repository.model.analystic;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Map;

@Document(collection = "jobs2")
public class Job {

    @Id
    private String id;

    private Map<String, Map<String, Integer>> qualifications_skill;

    // Getters and Setters
}

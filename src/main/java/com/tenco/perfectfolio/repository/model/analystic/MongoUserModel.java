package com.tenco.perfectfolio.repository.model.analystic;

import lombok.*;
import org.bson.Document;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@org.springframework.data.mongodb.core.mapping.Document(collection = "user_skills")
public class MongoUserModel {

    @Id
    private String id;

    // MySQL user pk
    @Field("user_id")
    private Integer userId;

    @Field("user_skill")
    private UserSkill userSkill;

    @Field("qualification")
    private Map<String, Integer> qualification;

    @Field("linguistics")
    private Map<String, Integer> linguistics;

    @Data
    @Builder
    public static class UserSkill {
        private Map<String, Integer> Language;
        private Map<String, Integer> Framework;
        private Map<String, Integer> SQL;
        private Map<String, Integer> NoSQL;
        private Map<String, Integer> DevOps;
        private Map<String, Integer> Service;
        // Getters and Setters
    }

    public Document toDocument() {
        Document userSkills = new Document();

        userSkills.put("userId", userId);

        if (userSkill != null) {
            userSkills.put("Language", mapToDocument(userSkill.getLanguage()));
            userSkills.put("Framework", mapToDocument(userSkill.getFramework()));
            userSkills.put("SQL", mapToDocument(userSkill.getSQL()));
            userSkills.put("NoSQL", mapToDocument(userSkill.getNoSQL()));
            userSkills.put("DevOps", mapToDocument(userSkill.getDevOps()));
            userSkills.put("Service", mapToDocument(userSkill.getService()));
        }

        if (qualification != null) {
            userSkills.put("qualification", mapToDocument(qualification));
        }

        if (linguistics != null) {
            userSkills.put("linguistics", mapToDocument(linguistics));
        }

        System.out.println("userSkills: " + userSkills);
        return userSkills;
    }

    private Document mapToDocument(Map<String, ?> map) {
        if (map == null) {
            return new Document();
        }
        return new Document(map);
    }
}

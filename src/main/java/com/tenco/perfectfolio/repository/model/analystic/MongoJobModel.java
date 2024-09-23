package com.tenco.perfectfolio.repository.model.analystic;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.bson.Document;
import org.springframework.data.annotation.Id;

import java.util.Map;

@Data
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MongoJobModel {

    @Id
    private String _id; // JSON의 "_id" 필드와 매핑

    @JsonProperty("id")
    private Integer boardId; // JSON의 "id" 필드와 매핑

    @JsonProperty("qualifications_skill")
    private QualificationsSkill qualificationsSkill; // JSON의 "qualifications_skill" 필드와 매핑

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class QualificationsSkill {

        @JsonProperty("Language")
        private Map<String, Integer> language; // JSON의 "Language" 필드와 매핑

        @JsonProperty("Framework")
        private Map<String, Integer> framework; // JSON의 "Framework" 필드와 매핑

        @JsonProperty("SQL")
        private Map<String, Integer> sql; // JSON의 "SQL" 필드와 매핑

        @JsonProperty("NoSQL")
        private Map<String, Integer> noSql; // JSON의 "NoSQL" 필드와 매핑

        @JsonProperty("DevOps")
        private Map<String, Integer> devOps; // JSON의 "DevOps" 필드와 매핑

        @JsonProperty("Service")
        private Map<String, Integer> service; // JSON의 "Service" 필드와 매핑

        public Document toDocument() {
            Document doc = new Document();
            doc.put("Language", new Document(this.language));
            doc.put("Framework", new Document(this.framework));
            doc.put("SQL", new Document(this.sql));
            doc.put("NoSQL", new Document(this.noSql));
            doc.put("DevOps", new Document(this.devOps));
            doc.put("Service", new Document(this.service));
            return doc;
        }
    }

    public Document toDocument() {
        Document doc = new Document();
        doc.put("board_id", this.boardId);
        doc.put("qualifications_skill", this.qualificationsSkill.toDocument());
        return doc;
    }
}

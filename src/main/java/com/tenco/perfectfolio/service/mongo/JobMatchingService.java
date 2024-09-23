package com.tenco.perfectfolio.service.mongo;

import com.tenco.perfectfolio.repository.model.analystic.JobSimilarityModel;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class JobMatchingService {

    @Autowired
    private MongoTemplate mongoTemplate;
    private Integer userId = null;

    public List<JobSimilarityModel> findMatchingJobs(Document userSkills) {
        userId = userSkills.getInteger("userId");

        // 1단계: combinedSkills와 userCombinedSkills 생성
        AggregationOperation addFieldsOperation = context -> new Document("$addFields",
                new Document("combinedSkills",
                        new Document("$concatArrays", Arrays.asList(
                                new Document("$objectToArray", "$qualifications_skill.Language"),
                                new Document("$objectToArray", "$qualifications_skill.Framework"),
                                new Document("$objectToArray", "$qualifications_skill.SQL"),
                                new Document("$objectToArray", "$qualifications_skill.NoSQL"),
                                new Document("$objectToArray", "$qualifications_skill.DevOps"),
                                new Document("$objectToArray", "$qualifications_skill.Service")
                        ))
                ).append("userCombinedSkills",
                        new Document("$concatArrays", Arrays.asList(
                                new Document("$objectToArray", userSkills.get("Language")),
                                new Document("$objectToArray", userSkills.get("Framework")),
                                new Document("$objectToArray", userSkills.get("SQL")),
                                new Document("$objectToArray", userSkills.get("NoSQL")),
                                new Document("$objectToArray", userSkills.get("DevOps")),
                                new Document("$objectToArray", userSkills.get("Service"))
                        ))
                )
        );

        // 2단계: matchingSkills와 cosineSimilarity 계산 (일치하거나 사용자의 스킬 레벨이 더 높을 경우 최대 유사도 부여)
        AggregationOperation calculateFieldsOperation = context -> new Document("$addFields",
                new Document("matchingSkills",
                        new Document("$sum",
                                new Document("$map",
                                        new Document("input", "$combinedSkills")
                                                .append("as", "jobSkill")
                                                .append("in",
                                                        new Document("$let",
                                                                new Document("vars",
                                                                        new Document("matchedUserSkill",
                                                                                new Document("$arrayElemAt", Arrays.asList(
                                                                                        new Document("$filter",
                                                                                                new Document("input", "$userCombinedSkills")
                                                                                                        .append("as", "userSkill")
                                                                                                        .append("cond",
                                                                                                                new Document("$eq", Arrays.asList("$$userSkill.k", "$$jobSkill.k"))
                                                                                                        )
                                                                                        ),
                                                                                        0
                                                                                ))
                                                                        )
                                                                ).append("in",
                                                                        new Document("$cond", Arrays.asList(
                                                                                new Document("$gte", Arrays.asList("$$matchedUserSkill.v", "$$jobSkill.v")),
                                                                                1, // 사용자의 스킬 레벨이 공고의 요구보다 크거나 같을 때 최대 유사도 부여
                                                                                new Document("$divide", Arrays.asList("$$matchedUserSkill.v", "$$jobSkill.v")) // 사용자의 스킬 레벨이 낮을 경우 비율 계산
                                                                        ))
                                                                )
                                                        )
                                                )
                                )
                        )
                ).append("cosineSimilarity",
                        new Document("$let",
                                new Document("vars",
                                        new Document("dotProduct",
                                                new Document("$sum",
                                                        new Document("$map",
                                                                new Document("input", "$combinedSkills")
                                                                        .append("as", "jobSkill")
                                                                        .append("in",
                                                                                new Document("$let",
                                                                                        new Document("vars",
                                                                                                new Document("matchedUserSkill",
                                                                                                        new Document("$arrayElemAt", Arrays.asList(
                                                                                                                new Document("$filter",
                                                                                                                        new Document("input", "$userCombinedSkills")
                                                                                                                                .append("as", "userSkill")
                                                                                                                                .append("cond",
                                                                                                                                        new Document("$eq", Arrays.asList("$$userSkill.k", "$$jobSkill.k"))
                                                                                                                                )
                                                                                                                ),
                                                                                                                0
                                                                                                        ))
                                                                                                )
                                                                                        ).append("in",
                                                                                                new Document("$multiply", Arrays.asList("$$jobSkill.v", "$$matchedUserSkill.v"))
                                                                                        )
                                                                                )
                                                                        )
                                                        )
                                                )
                                        ).append("jobSkillNorm",
                                                new Document("$sqrt",
                                                        new Document("$sum",
                                                                new Document("$map",
                                                                        new Document("input", "$combinedSkills")
                                                                                .append("as", "jobSkill")
                                                                                .append("in",
                                                                                        new Document("$multiply", Arrays.asList("$$jobSkill.v", "$$jobSkill.v"))
                                                                                )
                                                                )
                                                        )
                                                )
                                        ).append("userSkillNorm",
                                                new Document("$sqrt",
                                                        new Document("$sum",
                                                                new Document("$map",
                                                                        new Document("input", "$userCombinedSkills")
                                                                                .append("as", "userSkill")
                                                                                .append("in",
                                                                                        new Document("$multiply", Arrays.asList("$$userSkill.v", "$$userSkill.v"))
                                                                                )
                                                                )
                                                        )
                                                )
                                        )
                                ).append("in",
                                        new Document("$cond", Arrays.asList(
                                                new Document("$and", Arrays.asList(
                                                        new Document("$gt", Arrays.asList("$$jobSkillNorm", 0)),
                                                        new Document("$gt", Arrays.asList("$$userSkillNorm", 0))
                                                )),
                                                new Document("$divide", Arrays.asList("$$dotProduct", new Document("$multiply", Arrays.asList("$$jobSkillNorm", "$$userSkillNorm")))),
                                                0
                                        ))
                                )
                        )
                )
        );

        // 3단계: similarityScore 계산 (점진적 패널티 반영)
        AggregationOperation projectSimilarityScoreOperation = context -> new Document("$project",
                new Document("qualifications_skill", 1)
                        .append("board_id", 1)
                        .append("similarityScore",
                                new Document("$cond", Arrays.asList(
                                        new Document("$eq", Arrays.asList("$matchingSkills", new Document("$size", "$combinedSkills"))),
                                        1,
                                        new Document("$avg", Arrays.asList(
                                                new Document("$divide", Arrays.asList("$matchingSkills", new Document("$size", "$combinedSkills"))),
                                                "$cosineSimilarity"
                                        ))
                                ))
                        )
        );

        // 4단계: similarityScore 기준으로 매칭되는 결과 필터링
        AggregationOperation matchOperation = Aggregation.match(
                Criteria.where("similarityScore").gte(0.2)
        );

        Aggregation aggregation = Aggregation.newAggregation(
                addFieldsOperation,
                calculateFieldsOperation,
                projectSimilarityScoreOperation,
                matchOperation
        );

        AggregationResults<Document> results = mongoTemplate.aggregate(aggregation, "jobs2", Document.class);
        return results.getMappedResults().stream()
                .map(this::convertDocumentToJobSimilarityModel)
                .collect(Collectors.toList());
    }

    private JobSimilarityModel convertDocumentToJobSimilarityModel(Document document) {
        JobSimilarityModel jobSimilarityModel = new JobSimilarityModel();
        jobSimilarityModel.setUserId(userId);
        jobSimilarityModel.setBoardId(document.getInteger("board_id"));
        jobSimilarityModel.setQualificationsSkill((Map<String, Map<String, Integer>>) document.get("qualifications_skill"));
        Number similarityScore = document.get("similarityScore", Number.class);
        jobSimilarityModel.setSimilarityScore(similarityScore != null ? similarityScore.doubleValue() : null);
        return jobSimilarityModel;
    }
}

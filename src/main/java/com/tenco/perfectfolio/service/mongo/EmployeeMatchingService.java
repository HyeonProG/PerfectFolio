package com.tenco.perfectfolio.service.mongo;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class EmployeeMatchingService {

    @Autowired
    private MongoTemplate mongoTemplate;

    public List<Document> calculateFulfillmentRate(List<String> companyQualifications) {

        // MongoDB native operation for reduce
        Document reduceOperation = new Document("$reduce", new Document("input", Arrays.asList(
                new Document("$objectToArray", "$user_skill.Language"),
                new Document("$objectToArray", "$user_skill.Framework"),
                new Document("$objectToArray", "$user_skill.SQL"),
                new Document("$objectToArray", "$user_skill.NoSQL"),
                new Document("$objectToArray", "$user_skill.DevOps"),
                new Document("$objectToArray", "$user_skill.Service"),
                new Document("$objectToArray", "$qualification"),
                new Document("$objectToArray", "$linguistics")
        ))
                .append("initialValue", Arrays.asList())
                .append("in", new Document("$concatArrays", Arrays.asList("$$value", new Document("$map", new Document("input", "$$this")
                        .append("as", "item")
                        .append("in", "$$item.k"))))));

        // First stage of aggregation pipeline
        Document projectStage1 = new Document("$project", new Document("user_id", 1)
                .append("allSkills", reduceOperation));

        // $let operation to filter matched skills
        Document letOperation = new Document("$let", new Document("vars", new Document("companyQualifications", companyQualifications))
                .append("in", new Document("$size", new Document("$filter", new Document("input", "$$companyQualifications")
                        .append("as", "requirement")
                        .append("cond", new Document("$in", Arrays.asList("$$requirement", new Document("$ifNull", Arrays.asList("$allSkills", Arrays.asList())))))))));

        // Second stage of aggregation pipeline
        Document projectStage2 = new Document("$project", new Document("user_id", 1)
                .append("matchedSkills", letOperation)
                .append("totalRequirements", new Document("$literal", companyQualifications.size())));

        // Final stage to calculate fulfillment rate
        Document projectStage3 = new Document("$project", new Document("user_id", 1)
                .append("matchedSkills", 1)
                .append("totalRequirements", 1)
                .append("fulfillmentRate", new Document("$cond", new Document("if", new Document("$gt", Arrays.asList("$totalRequirements", 0)))
                        .append("then", new Document("$divide", Arrays.asList("$matchedSkills", "$totalRequirements")))
                        .append("else", 0))));

        // Aggregation pipeline
        Aggregation aggregation = Aggregation.newAggregation(
                context -> projectStage1,
                context -> projectStage2,
                context -> projectStage3
        );

        // Execute the aggregation
        AggregationResults<Document> results = mongoTemplate.aggregate(aggregation, "user_skills", Document.class);
        return results.getMappedResults();
    }
}

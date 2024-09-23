package com.tenco.perfectfolio.service.mongo;

import com.tenco.perfectfolio.repository.model.analystic.TrendModel;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrendSkillService {
    @Autowired
    private MongoTemplate mongoTemplate;

    public List<TrendModel> getTrendskill(String startDate, String endDate) {
        // Step 1: 날짜 범위로 해당 문서의 수 (requirecount)를 계산
        MatchOperation dateMatchOperation = Aggregation.match(Criteria.where("migratedAt").gte(startDate).lte(endDate));
        GroupOperation countTotalDocs = Aggregation.group().count().as("requirecount");

        Aggregation countAggregation = Aggregation.newAggregation(
                dateMatchOperation,
                countTotalDocs
        );

        AggregationResults<Document> countResults = mongoTemplate.aggregate(countAggregation, "jobs", Document.class);
        Integer requirecount = countResults.getUniqueMappedResult() != null ? countResults.getUniqueMappedResult().getInteger("requirecount") : 0;

        // Step 2: 기존의 스킬 관련 쿼리 실행
        MatchOperation matchOperation = Aggregation.match(Criteria.where("migratedAt").gte(startDate).lte(endDate));
        ProjectionOperation projectSkills = Aggregation.project()
                .andExpression("{ $objectToArray: '$qualifications_skill' }").as("skills");
        UnwindOperation unwindSkills = Aggregation.unwind("skills");
        ProjectionOperation projectSubSkills = Aggregation.project()
                .andExpression("{ $objectToArray: '$skills.v' }").as("subSkills");
        UnwindOperation unwindSubSkills = Aggregation.unwind("subSkills");
        GroupOperation groupBySkill = Aggregation.group("subSkills.k")
                .sum("subSkills.v").as("totalCount");
        SortOperation sortByCount = Aggregation.sort(Sort.by(Sort.Direction.DESC, "totalCount"));
        LimitOperation limitTo8 = Aggregation.limit(8);
        ProjectionOperation projectFinal = Aggregation.project()
                .and("_id").as("skillname")
                .and("totalCount").as("count");

        Aggregation aggregation = Aggregation.newAggregation(
                matchOperation,
                projectSkills,
                unwindSkills,
                projectSubSkills,
                unwindSubSkills,
                groupBySkill,
                sortByCount,
                limitTo8,
                projectFinal
        );

        AggregationResults<TrendModel> results = mongoTemplate.aggregate(aggregation, "jobs", TrendModel.class);

        // Step 3: requirecount 값을 모든 결과에 동일하게 적용
        List<TrendModel> trendModels = results.getMappedResults();
        for (TrendModel model : trendModels) {
            model.setRequirecount(requirecount);  // requirecount 값을 설정
        }

        return trendModels;
    }
}

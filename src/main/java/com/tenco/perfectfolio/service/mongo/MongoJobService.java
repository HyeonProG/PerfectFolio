package com.tenco.perfectfolio.service.mongo;


import com.tenco.perfectfolio.repository.model.analystic.MongoJobModel;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MongoJobService {

    private final MongoTemplate mongoTemplate;

    @Autowired
    public MongoJobService(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public void saveJobs(List<MongoJobModel> jobModels) {
        List<Document> documents = jobModels.stream()
                .map(MongoJobModel::toDocument)
                .collect(Collectors.toList());

        mongoTemplate.insert(documents, "jobs2");
        //TODO 컬렉션명 변경
    }

}

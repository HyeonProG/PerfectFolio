package com.tenco.perfectfolio.service.mongo;

import com.tenco.perfectfolio.repository.model.analystic.MongoJobModel;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import com.mongodb.client.result.DeleteResult;

import java.util.ArrayList;
import java.util.List;

@Service
public class JobDataMigrationService {

    @Autowired
    private MongoTemplate mongoTemplate;

    // jobs2 컬렉션에서 데이터를 가져와 jobs1 컬렉션에 삽입하고 삭제하는 메서드
    public void migrateJobsData() {
        // 1. jobs2 컬렉션의 데이터를 Document로 모두 가져옴
        List<Document> jobs2Data = mongoTemplate.findAll(Document.class, "jobs2");
        System.out.println(jobs2Data);
        if (!jobs2Data.isEmpty()) {
            // 2. jobs1 컬렉션에 Document 삽입
            mongoTemplate.insert(jobs2Data, "jobs");

            // 3. jobs2 컬렉션의 모든 데이터 삭제
            Query query = new Query(); // 모든 문서를 삭제하기 위한 빈 쿼리
            mongoTemplate.remove(query, "jobs2");

            System.out.println("jobs2 데이터가 성공적으로 jobs1으로 이동되었습니다.");
        } else {
            System.out.println("jobs2 컬렉션에 데이터가 없습니다.");
        }
    }
    // 새로운 데이터를 jobs2 컬렉션에 넣는 메서드
    public void insertNewJobsData(List<MongoJobModel> newJobsData) {
        // jobs2 컬렉션에 새로운 데이터 삽입
        mongoTemplate.insert(newJobsData, "jobs2");
    }
}

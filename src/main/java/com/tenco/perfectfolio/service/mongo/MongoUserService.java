package com.tenco.perfectfolio.service.mongo;

import com.tenco.perfectfolio.repository.interfaces.analystic.MongoUserRepository;
import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class MongoUserService {

    @Autowired
    private MongoUserRepository mongoUserRepository;

    @Transactional
    public MongoUserModel findByUserId(Integer userId) {
        return mongoUserRepository.findByUserId(userId);
    }

    @Transactional
    public MongoUserModel saveOrUpdateUserSkill(Integer userId, Map<String, Object> userData) {

        System.out.println("service SaveOrupdate : " + userData);
        MongoUserModel.UserSkill userSkill = MongoUserModel.UserSkill.builder()
                .Language((Map<String, Integer>) userData.get("Language"))
                .Framework((Map<String, Integer>) userData.get("Framework"))
                .SQL((Map<String, Integer>) userData.get("SQL"))
                .NoSQL((Map<String, Integer>) userData.get("NoSQL"))
                .DevOps((Map<String, Integer>) userData.get("DevOps"))
                .Service((Map<String, Integer>) userData.get("Service"))
                .build();
        System.out.println("service SaveOrupdate : " + userSkill);
        System.out.println("servicdsafsdfnjkdnwqjkn : " + (Map<String, Integer>) userData.get("Service"));
        Map<String, Integer> qualification = (Map<String, Integer>) userData.get("qualification");
        Map<String, Integer> linguistics = (Map<String, Integer>) userData.get("linguistics");
        System.out.println("Qualification : " + qualification);
        System.out.println("Linguistics : " + linguistics);
        // 새로운 MongoUserModel 생성
        MongoUserModel mongoUserModel = MongoUserModel.builder()
                .userId(userId)         // 세션에서 가져온 userId 설정
                .userSkill(userSkill)   // JSON 데이터에서 추출한 UserSkill 설정
                .qualification(qualification)
                .linguistics(linguistics)
                .build();

        System.out.println("service SaveOrupdate : " + mongoUserModel);

        MongoUserModel existingUser = mongoUserRepository.findByUserId(userId);

        if (existingUser != null) {
            // 기존 데이터가 있으면 업데이트 (덮어쓰기)
            existingUser.setUserSkill(mongoUserModel.getUserSkill());
            existingUser.setQualification(qualification);
            existingUser.setLinguistics(linguistics);
            return mongoUserRepository.save(existingUser);
        } else {
            // 기존 데이터가 없으면 새로 생성
            return mongoUserRepository.save(mongoUserModel);
        }
    }

    @Transactional
    public List<MongoUserModel> findAll() {
        return mongoUserRepository.findAll();
    }
}
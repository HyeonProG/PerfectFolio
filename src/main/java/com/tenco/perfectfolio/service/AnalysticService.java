package com.tenco.perfectfolio.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import com.tenco.perfectfolio.repository.interfaces.analystic.UserTestRepo;

@Service
public class AnalysticService {

    @Autowired
    private UserTestRepo testRepo;
    @Autowired
    private MongoTemplate mongoTemplate;

    public MongoUserModel createUser(Map<String, Object> resultData) {
    	
    	Map<String, List<String>> qualificationsSkill = (Map<String, List<String>>) resultData.get("qualifications_skill");
    	
        Map<String, Integer> languageSkills = new HashMap<>();
        Map<String, Integer> frameworkSkills = new HashMap<>();
        Map<String, Integer> sqlSkills = new HashMap<>();
        Map<String, Integer> noSqlSkills = new HashMap<>();
        Map<String, Integer> devOpsSkills = new HashMap<>();
        Map<String, Integer> serviceSkills = new HashMap<>();
        
        for (String key : qualificationsSkill.keySet()) {
            if(qualificationsSkill.get(key).size() > 0 && qualificationsSkill.get(key) != null) {
            	
            for (String skill : qualificationsSkill.get(key)) {
            	String[] skillNameAndLevel = skill.split("/");

            	skillNameAndLevel[0] = skillNameAndLevel[0].replaceAll(".", "_");
            	
            	if("Language".equalsIgnoreCase(key)) {
            		languageSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	} else if ("Framework".equalsIgnoreCase(key)) {
            		frameworkSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	} else if ("SQL".equalsIgnoreCase(key)) {
            		sqlSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	} else if ("NoSQL".equalsIgnoreCase(key)) {
            		noSqlSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	} else if ("DevOps".equalsIgnoreCase(key)) {
            		devOpsSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	} else if ("Service".equalsIgnoreCase(key)) {
            		serviceSkills.put(skillNameAndLevel[0], Integer.parseInt(skillNameAndLevel[1]));
            	}
            }
            }
        }

        MongoUserModel user = MongoUserModel.builder()
        					.userId((Integer)resultData.get("user_id"))
        					.userSkill(
									MongoUserModel.UserSkill.builder()
        							.Language(languageSkills)
        							.Framework(frameworkSkills)
        							.SQL(sqlSkills)
        							.NoSQL(noSqlSkills)
        							.DevOps(devOpsSkills)
        							.Service(serviceSkills)
        							.build())
        					.build();
        return testRepo.save(user);
    }
}

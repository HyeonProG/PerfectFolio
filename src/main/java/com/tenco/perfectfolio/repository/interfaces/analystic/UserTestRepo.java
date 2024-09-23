package com.tenco.perfectfolio.repository.interfaces.analystic;

import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UserTestRepo extends MongoRepository<MongoUserModel, String> {

    List<MongoUserModel> findAll();


}

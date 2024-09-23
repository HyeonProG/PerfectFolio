package com.tenco.perfectfolio.repository.interfaces.analystic;

import com.tenco.perfectfolio.repository.model.analystic.MongoUserModel;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface MongoUserRepository extends MongoRepository<MongoUserModel,String> {

    MongoUserModel findByUserId(Integer userId);
}

package com.tenco.perfectfolio.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tenco.perfectfolio.repository.interfaces.analystic.JobNoticeRepository;
import com.tenco.perfectfolio.repository.model.RecommendCompanies;
import com.tenco.perfectfolio.repository.model.analystic.JobNotice;
import com.tenco.perfectfolio.repository.model.analystic.JobSimilarityModel;
import com.tenco.perfectfolio.repository.model.analystic.MongoJobModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class JobNoticeService {

    @Autowired
    private JobNoticeRepository jobNoticeRepository;
    @Autowired
    private ObjectMapper objectMapper;

    public JobNotice findById(Integer id) {
        JobNotice jobNotice = jobNoticeRepository.findById(id);
        if(jobNotice != null) {
            return jobNotice;
        }
        return null;
    }
    @Transactional
    public List<RecommendCompanies> getRecommendCompanies(Integer id, Integer limit, String similarityOption, String dateOption, String qualificationOption) {
        List<RecommendCompanies> recommendCompaniesList = jobNoticeRepository.findRecommendCompanies(id, limit, dateOption,similarityOption, qualificationOption);
        return recommendCompaniesList;
    }

    @Transactional
    public List<MongoJobModel> getJobsByDate(String date){
        List<String> jsonList = jobNoticeRepository.findByDate(date);

        return jsonList.stream().map(json -> {
            try {
                return objectMapper.readValue(json, MongoJobModel.class);
            } catch (Exception e) {
                throw new RuntimeException("Failed to map JSON to MongoJobModel", e);
            }
        }).collect(Collectors.toList());
    }
    @Transactional
    public int insertJobSimilarity(List<List<JobSimilarityModel>> jobSimilarityModels) {

        int result = 0;
        result = jobNoticeRepository.insertJobSimilarity(jobSimilarityModels);

        return result;
    }
}



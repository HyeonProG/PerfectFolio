package com.tenco.perfectfolio.repository.interfaces.analystic;

import com.tenco.perfectfolio.dto.RecommendedDTO;
import com.tenco.perfectfolio.repository.model.RecommendCompanies;
import com.tenco.perfectfolio.repository.model.analystic.JobNotice;
import com.tenco.perfectfolio.repository.model.analystic.JobSimilarityModel;
import com.tenco.perfectfolio.repository.model.analystic.MongoJobModel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.sql.Date;
import java.util.List;

@Mapper
public interface JobNoticeRepository {

    public JobNotice findById(Integer id);
    public List<RecommendCompanies> findRecommendCompanies(Integer id, Integer limit, String similarityOption, String dateOption, String qualificationOption);

    public int insertJobSimilarity(List<List<JobSimilarityModel>> jobSimilarityModel);

    //yyyy-mm-dd
    @Select("SELECT mongo_json FROM crawl_skill_json WHERE DATE(created_at) = #{date} and mongo_json is not null")
    public List<String> findByDate(String date);
}

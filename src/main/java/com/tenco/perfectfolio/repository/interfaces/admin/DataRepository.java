package com.tenco.perfectfolio.repository.interfaces.admin;

import com.tenco.perfectfolio.dto.admin.CategoryDTO;

import java.util.List;

import com.tenco.perfectfolio.repository.model.admin.JsonlModel;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DataRepository {

    public Integer getSingleOriginDataId();
    public Integer getRandomOriginDataId();

    public String getSingleOriginData(int id);

    public void insertCategory(String tableName,String categoryName);

    public void insertResultAndResponseData(Integer id, String resultData, String responseData);

    public List<JsonlModel> makeJsonlFile();

    public String putSingleOriginData(int id);

    // 카테고리 전체 출력을 위한 인터페이스
    public List<CategoryDTO> getAllCategory(); 
    
    // 사용자 기술 스택 생성을 위한 카테고리 전체 출력을 위한 인터페이스
    public List<CategoryDTO> getSkillAllCategory();

    // Qualifications + Linguistic 카테고리 출력
    public List<CategoryDTO> getAllQualifications();
    
    
}

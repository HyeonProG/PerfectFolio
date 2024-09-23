package com.tenco.perfectfolio.repository.interfaces;

import com.tenco.perfectfolio.repository.model.tempModel;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface tempRepo {

    public List<tempModel> findAll();


}

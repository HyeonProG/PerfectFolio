package com.tenco.perfectfolio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmailRepository {

    public void sendMail(String to, String subject, String templateName, String text);

}

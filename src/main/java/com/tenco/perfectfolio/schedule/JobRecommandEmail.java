package com.tenco.perfectfolio.schedule;

import com.tenco.perfectfolio.repository.model.analystic.RecommendationCountModel;
import com.tenco.perfectfolio.service.EmailService;
import com.tenco.perfectfolio.service.mongo.RecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
public class JobRecommandEmail {

    @Autowired
    private RecommendationService recommendationService;

    @Autowired
    private EmailService emailService;

    @Scheduled(cron = "0 0 7 * * *")
    public void logActiveSessions() { //schedule 은 항상 public 으로 선언해야 함
        LocalDate today = LocalDate.now();
        List<RecommendationCountModel> recomandemails = recommendationService.countRecommendations(today);
        for (RecommendationCountModel recomandemail : recomandemails) {
            System.out.println(recomandemail);
            emailService.sendRecommendation(recomandemail.getUserEmail(), recomandemail.getUserName(), recomandemail.getRecommendationCount());
        }
    }

}

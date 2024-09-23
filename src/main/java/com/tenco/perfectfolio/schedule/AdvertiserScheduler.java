package com.tenco.perfectfolio.schedule;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.tenco.perfectfolio.repository.model.advertiser.Advertiser;
import com.tenco.perfectfolio.service.AdvertiserService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdvertiserScheduler {
	
	private final AdvertiserService advertiserService;

    // 광고주 ID별 차감 금액을 저장할 Map
    private Map<Integer, Integer> pendingDeductions = new ConcurrentHashMap<>();

    // 이미지 노출 횟수를 저장할 Map
    private Map<String, Integer> imageViewCounts = new ConcurrentHashMap<>();

    private Map<String, Integer> imageClickCounts = new ConcurrentHashMap<>();
    
    // 금액 차감 요청을 메모리에 추가하는 메서드
    public void addDeduction(Integer userId, Integer amount) {
        pendingDeductions.merge(userId, amount, (existingAmount, newAmount) -> existingAmount + newAmount);
    }
    
    // 이미지 노출 횟수를 기록하는 메서드
    public void addImageViewCount(String uploadFileName) {
        imageViewCounts.merge(uploadFileName, 1, (existingCount, increment) -> existingCount + increment); // 노출될 때마다 +1
    }

    // 특정 주기마다 이 메서드를 호출해 차감 처리
    @Scheduled(fixedRate = 10000) // 10초마다
    public void processPendingDeductions() {
        for (Map.Entry<Integer, Integer> entry : pendingDeductions.entrySet()) {
        	Integer userId = entry.getKey();
        	Integer amount = entry.getValue();

            // 서비스 계층에서 잔액 차감 처리
            try {
                // 차감할 금액을 광고주의 잔액에서 뺌
                advertiserService.updateBalance(userId, amount);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 차감 처리가 끝나면 Map을 초기화
        pendingDeductions.clear();
    }
    
    // 특정 주기마다 노출 횟수를 DB에 저장하는 메서드
    @Scheduled(fixedRate = 10000) // 10초마다
    public void processImageViewCounts() {
        for (Map.Entry<String, Integer> entry : imageViewCounts.entrySet()) {
            String uploadFileName = entry.getKey();
            int viewCount = entry.getValue();

            try {
                // 이미지 노출 횟수를 DB에 업데이트하는 로직
                advertiserService.updateImageViewCount(uploadFileName, viewCount);
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println("viewCount : " + viewCount);
        }

        // DB 저장이 완료되면 Map을 초기화
        imageViewCounts.clear();
    }
    
    // 특정 주기마다 노출 횟수를 DB에 저장하는 메서드
    @Scheduled(fixedRate = 10000) // 10초마다
    public void processImageClickCounts() {
        for (Map.Entry<String, Integer> entry : imageClickCounts.entrySet()) {
            String uploadFileName = entry.getKey();
            int clickCount = entry.getValue();

            try {
                // 이미지 노출 횟수를 DB에 업데이트하는 로직
                advertiserService.incrementClickCount(uploadFileName, clickCount);
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println("clickCount : " + clickCount);
        }

        // DB 저장이 완료되면 Map을 초기화
        imageClickCounts.clear();
    }
    
}

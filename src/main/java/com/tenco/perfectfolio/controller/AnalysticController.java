package com.tenco.perfectfolio.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.tenco.perfectfolio.dto.PrincipalDTO;
import com.tenco.perfectfolio.repository.model.analystic.*;
import com.tenco.perfectfolio.service.AnalysticService;
import com.tenco.perfectfolio.service.EmailService;
import com.tenco.perfectfolio.service.JobNoticeService;
import com.tenco.perfectfolio.service.mongo.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@CrossOrigin(origins = "http://127.0.0.1:5500")  // 특정 도메인 허용
@Controller
@RequiredArgsConstructor
@RequestMapping("/analystic")
public class AnalysticController {

    @Autowired
    private AnalysticService analysticService;
    @Autowired
    private JobMatchingService  jobMatchingService;
    @Autowired
    MongoUserService mongoUserService;
    @Autowired
    private HttpSession session;
    @Autowired
    private JobNoticeService jobNoticeService;
    @Autowired
    private MongoJobService mongoJobService;
    @Autowired
    private EmployeeMatchingService employeeMatchingService;
    @Autowired
    private JobDataMigrationService jobDataMigrationService;
    @Autowired
    private TrendSkillService trendSkillService;
    @Autowired
    private RecommendationService recommendationService;
    @Autowired
    private EmailService emailService;

    @GetMapping("/trendskills")
    @ResponseBody
    public List<TrendModel> getTrendSkills(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return trendSkillService.getTrendskill(startDate,endDate);
    }

    @GetMapping("/test6")
    @ResponseBody
    public List<RecommendationCountModel> test6(){
        LocalDate today = LocalDate.now();
        LocalDate yesterday = LocalDate.now().minusDays(1);
        List<RecommendationCountModel> recomandemails = recommendationService.countRecommendations(yesterday);
        for (RecommendationCountModel recomandemail : recomandemails) {
            System.out.println(recomandemail);
            emailService.sendRecommendation(recomandemail.getUserEmail(), recomandemail.getUserName(), recomandemail.getRecommendationCount());
        }
        return recommendationService.countRecommendations(today);
    }

    // user 개인 기술 스택 조회
    @GetMapping("/userskill")
    @ResponseBody
    public MongoUserModel getUserSkill() {
        MongoUserModel mongoUserModel = mongoUserService.findByUserId(2);
        if (mongoUserModel == null) {
            //TODO : mongo null 값 처리 throw exception
            // 사용자에게 알림 날림
            System.out.println("mongoUserModel is null");
        }
        return mongoUserModel;
    }
    // user 개인 기술스택 생성 및 업데이트
    // 테스트 완료
    @PostMapping("/create")
    public ResponseEntity createAndUpdateUserSkill(@RequestBody Map<String, Object> userData) {
//        // 세션에서 userId 가져오기
        PrincipalDTO principal = (PrincipalDTO) session.getAttribute("principal");
        int userId = principal.getId();
        Map<String, Object> userSkillList = new HashMap<>();
        System.out.println("userData111111111111" + userData);
        // userData에서 각 항목 처리
        for (Map.Entry<String, Object> entry : userData.entrySet()) {
            String key = entry.getKey();
            System.out.println("Processing key: " + key);

                List<String> values = (List<String>) entry.getValue();

                Map<String, Integer> skillMap = new HashMap<>();
                for (String value : values) {
                    String[] parts = value.split("/"); // 예: "JAVA/3" -> ["JAVA", "3"]
                    if (parts.length == 2) {
                        try {
                            skillMap.put(parts[0], Integer.parseInt(parts[1])); // key: "JAVA", value: 3 (정수로 저장)
                        } catch (NumberFormatException e) {
                            System.out.println("Error parsing skill level for " + value);
                        }
                    } else if ("qualification".equalsIgnoreCase(key) || "linguistics".equalsIgnoreCase(key)) {
                        skillMap.put(parts[0], 1);
                    }
                }
                userSkillList.put(key, skillMap);
            }


        // Gson을 사용하여 JSON으로 변환
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String jsonOutput = gson.toJson(userSkillList);

        // MongoDB에 저장할 때 Map을 그대로 사용
        MongoUserModel savedUserSkill = mongoUserService.saveOrUpdateUserSkill(userId, userSkillList);

        // JSON 출력
        System.out.println("Final JSON Output: " + jsonOutput);
        System.out.println("Final savedUserSkill: " + savedUserSkill.toString());

        // 저장 성공 메시지 반환
        return ResponseEntity.ok().body(jsonOutput);
    }
    /**
     * 기업이 입력한 필터 기반으로 유저 조회
     * @param qualifications
     * @return
     */
    @PostMapping("/employee")
    @ResponseBody
    public List<Document> getEmployeeMatching(@RequestBody List<String> skills) {
        System.out.println(skills);
        //테스트용 리스트
        //List<String> companyQualifications = List.of( "GO", "MYSQL", "DYNAMODB", "KUBERNETES", "ARGOCD", "GITHUB ACTION", "REST API", "KAFKA", "ROCKETMQ");
        return employeeMatchingService.calculateFulfillmentRate(skills);
    }
    /**
     * 크론 테스트용
     * 전체 유저 유사도 테스트 진행
     */
    @GetMapping("/test2")
    @ResponseBody
    public List<List<JobSimilarityModel>> test2(){
        List<List<JobSimilarityModel>> jobSimilarityModelListAllUser = new ArrayList<>();
        List<MongoUserModel> mongoUserModelList = mongoUserService.findAll();
            for (MongoUserModel mongoUserModel : mongoUserModelList) {
               jobSimilarityModelListAllUser.add(jobMatchingService.findMatchingJobs(mongoUserModel.toDocument()));
            }

            if (!jobSimilarityModelListAllUser.isEmpty()) {
                jobNoticeService.insertJobSimilarity(jobSimilarityModelListAllUser);
            }
            System.out.println(jobSimilarityModelListAllUser.toString());
            //첫번째 유저와 첫번째 공고문의 유사도
        System.out.println(jobSimilarityModelListAllUser.get(0).get(0).getUserId());
        System.out.println(jobSimilarityModelListAllUser.get(0).get(0).getSimilarityScore());
            //두번째 유저와 첫번째 공고문의 유사도
        System.out.println(jobSimilarityModelListAllUser.get(1).get(0).getUserId());
        System.out.println(jobSimilarityModelListAllUser.get(1).get(1).getUserId());
        System.out.println(jobSimilarityModelListAllUser.get(1).get(0).getSimilarityScore());
        return jobSimilarityModelListAllUser;
    }

    /**
     * 크론 테스트용
     * 전체 자동화 테스트
     */
    @GetMapping("/test5")
    public String test5(){
        List<List<JobSimilarityModel>> jobSimilarityModelListAllUser = new ArrayList<>();

        //mysql에서 데이터 가지고 오기
        LocalDate today = LocalDate.now();
        //yyyy-MM-dd 형식
        List<MongoJobModel> mongoJobModels = jobNoticeService.getJobsByDate(today.toString());
        //List<MongoJobModel> mongoJobModels = jobNoticeService.getJobsByDate("2024-09-19");
        System.out.println(today.toString()+"의 데이터 mysql로부터 로드");


        mongoJobService.saveJobs(mongoJobModels);
        System.out.println("jobs2에 데이터 저장 완료");
        //가지고온 데이터 분석 시작(jobs2 collection)


        List<MongoUserModel> mongoUserModelList = mongoUserService.findAll();
        System.out.println("--- 유저와 공고문 데이터 유사도 분석 시작 ---");
        for (MongoUserModel mongoUserModel : mongoUserModelList) {
            jobSimilarityModelListAllUser.add(jobMatchingService.findMatchingJobs(mongoUserModel.toDocument()));
        }
        System.out.println("!!! 유저와 공고문 데이터 유사도 분석 종료 !!!");



        //분석한 데이터 저장(mysql)
        System.out.println("--- 유사도 데이터 저장 시작 ---");
        if (!jobSimilarityModelListAllUser.isEmpty()) {
            jobNoticeService.insertJobSimilarity(jobSimilarityModelListAllUser);
        }
        System.out.println("!!! 유사도 데이터 저장 종료 !!!");
        //jobs2 -> jobs1 이동(jobs2 클린 진행)
        System.out.println("--- jobs2 -> jobs1 이동 시작 ---");
        jobDataMigrationService.migrateJobsData();
        System.out.println("!!! jobs2 -> jobs1 이동 종료 !!!");
        return null;
    }


    /**
     * mysql에서 클로링 하고 ai 가공 거친 데이터 받아와서 job2로 넣는 테스트용
     * @return
     */
    @GetMapping("/test3")
    public String test3(){
        LocalDate today = LocalDate.now();
        List<MongoJobModel> mongoJobModels = jobNoticeService.getJobsByDate(today.toString());
        mongoJobService.saveJobs(mongoJobModels);
        //TODO - jo2 로 저장정 기존 job2 -> jo1 으로 이동 시킥고 job2에 데이터 넣기
        // 이후 job2 데이터 기반으로 유사도 계산후 db에 저장
        return null;
    }

    @GetMapping("/test4")
    public String test4(){

        //TODO -jobs2 전체 데이터 jobs로 이동 시키기
        jobDataMigrationService.migrateJobsData();


        return null;
    }

    @GetMapping("/test")
    public String test() {
        System.out.println("test begin");

        Document userSkills = new Document();

        //임시 유저 객체
        //
        userSkills.put("userId", 1);
        userSkills.put("Language", new Document()
                .append("JAVA", 3)
                .append("GO", 3)
        );
        userSkills.put("Framework", new Document());
        userSkills.put("SQL", new Document("MYSQL", 3));
        userSkills.put("NoSQL", new Document("DYNAMODB", 2));
        userSkills.put("DevOps", new Document()
                .append("KUBERNETES", 3)
                .append("ARGOCD", 2)
                .append("GITHUB ACTION", 2));
        userSkills.put("Service", new Document()
                .append("REST API", 3)
                .append("KAFKA", 2)
                .append("ROCKETMQ", 2));


        System.out.println(jobMatchingService.findMatchingJobs(userSkills));
        JobSimilarityModel temp = jobMatchingService.findMatchingJobs(userSkills).get(0);
        System.out.println(temp.getQualificationsSkill().get("Language"));
        System.out.println(temp.getSimilarityScore());
        return null;
    }
}

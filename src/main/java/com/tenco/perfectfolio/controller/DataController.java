package com.tenco.perfectfolio.controller;


import com.tenco.perfectfolio.dto.admin.CategoryDTO;
import com.tenco.perfectfolio.service.DataService;
import com.tenco.perfectfolio.utils.Json;
import com.tenco.perfectfolio.utils.StrUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/data")
public class DataController {


    @Autowired
    private DataService dataService;
    @Autowired
    private HttpSession session;




    /**
     * url : http://localhost:8080/data/jsontojsonl
     * @param model
     * @return
     */
    @GetMapping("/jsontojsonl")
    public String getDataId(Model model) {
        //TODO : make jsp
        System.out.println("json to jsonl");
        return "admin/dataBuild";
    }

    @GetMapping("/get-data-id")
    @ResponseBody
    public String getDataId() {
        Integer id = dataService.getSingleOriginDataId();
        return id.toString();
    }
    @GetMapping("/get-rnd-data-id")
    @ResponseBody
    public String getRandomDataId() {
        Integer id = dataService.getRandomOriginDataId();
        return id.toString();
    }

    /**
     * Post 방식으로 JSON 데이터를 받아서 처리하는 메소드
     * @param requestData
     * @return
     */
    @PostMapping("/insert-data")
    @ResponseBody
    public String insertData(@RequestParam("id") String id
                            , @RequestBody String requestData
                            ,HttpServletRequest request) {

        System.out.println("Received ID " + id);
        //json 원본
        System.out.println("Received JSON: " + requestData);

        // json 데이터 이스케이프 문자열 처리
        System.out.println("Received Escape JSON: " + StrUtil.escapeJsonString(requestData));

        //TODO - upLoad log
        // 클라이언트의 IP 주소 가져오기
        String clientIpAddress = request.getRemoteAddr();
        System.out.println("Client IP Address: " + clientIpAddress);

        // 클라이언트의 브라우저 정보(User-Agent) 가져오기
        String userAgent = request.getHeader("User-Agent");
        System.out.println("User-Agent: " + userAgent);

        //TODO - database exception check
        // OR make a handler
        dataService.insertResultAndResponseData(Integer.parseInt(id), requestData, StrUtil.escapeJsonString(requestData));

        return "success";
    }


    /**
     * url : http://localhost:8080/data/get-data?id=1
     * @return
     */
    @GetMapping("/get-data")
    @ResponseBody
    public String getData(@RequestParam(name = "id") int id) {
        String data = dataService.getSingleOriginData(id);
        return Json.jsonToBeauty(data);
    }

    @GetMapping("/insert-category")
    @ResponseBody
    public String insertCategory(@RequestParam String tableName, @RequestParam String categoryName) {
    	dataService.insertCategory(tableName, categoryName);
    	return "success";
    }
    
    /**
     * @author KNC
     * 각 분류된 카테고리를 반환하는 메소드
     * @return
     */
    @GetMapping("/category")
    public String getCategoryPage() {
    	return "admin/categoryBefore";
    }
    
    @GetMapping("/category/all")
    @ResponseBody
    public Map<String, List<CategoryDTO>> getAllCategoryProc() {
    	Map<String, List<CategoryDTO>> allCategoryList = dataService.getAllCategory();
    	return allCategoryList;
    }

    @GetMapping("/makefile")
    public void makeJsonlFile() throws IOException {
        dataService.makeJsonlFile();
    }
    
    @GetMapping("/mongo/category")
    @ResponseBody
    public Map<String, List<CategoryDTO>> getAllMongoCategoryProc() {
    	Map<String, List<CategoryDTO>> allCategoryList = dataService.getSkillAllCategory();

    	return allCategoryList;
    }
    
    
}

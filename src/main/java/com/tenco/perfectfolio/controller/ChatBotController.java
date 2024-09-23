package com.tenco.perfectfolio.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.tenco.perfectfolio.service.ChatBotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chat")
public class ChatBotController {

    @Autowired
    private ChatBotService chatBotService;

    @GetMapping("/chatPage")
    public String chatPage() {
        return "user/chatBot";
    }

//    @PostMapping("/sendMessage")
//    @ResponseBody
//    public ResponseEntity<String> sendMessage(@RequestBody String body) {
//        String chatbotMessage;
//        System.out.println("body : " + body);
//        try {
//            // JSON 문자열을 JsonObject로 변환
//            JsonObject jsonObject = new Gson().fromJson(body, JsonObject.class);
//            String userMessage = jsonObject.get("message").getAsString();
//
//            // 챗봇 서비스 호출
//            chatbotMessage = chatBotService.getChatBotMessage(userMessage);
//        } catch (Exception e) {
//            e.printStackTrace();
//            chatbotMessage = "Error: " + e.getMessage();
//        }
//
//        return new ResponseEntity<>(chatbotMessage, HttpStatus.OK);
//    }
}
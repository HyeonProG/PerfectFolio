package com.tenco.perfectfolio.handler;

import com.tenco.perfectfolio.service.ChatBotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final ChatBotService chatBotService;

    @Autowired
    public ChatWebSocketHandler(ChatBotService chatBotService) {
        this.chatBotService = chatBotService;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        System.out.println("payload : " + payload);
        String response = generateResponse(payload);

        System.out.println("response : " + response);
        // 챗봇 응답을 클라이언트에게 전송합니다.

        session.sendMessage(new TextMessage(response));
    }

    private String generateResponse(String message) {
        // ChatBotService를 통해 챗봇과 상호작용하고 응답을 생성합니다.


        return chatBotService.getChatBotMessage(message);
    }
}
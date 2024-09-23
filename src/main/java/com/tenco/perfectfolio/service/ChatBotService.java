package com.tenco.perfectfolio.service;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
//import org.apache.tomcat.util.codec.binary.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Base64;

@Service
public class ChatBotService {

    @Value("${clova.chatbot.api-url}")
    private String apiUrl;

    @Value("${clova.chatbot.client-id}")
    private String clientId;

    @Value("${clova.chatbot.client-secret}")
    private String clientSecret;

    // Main method to get chatbot response
    public String getChatBotMessage(String voiceMessage) {

        String chatbotMessage = "";
        System.out.println("this is Service"+voiceMessage);
        try {
            // Setup connection
            URL url = new URL(apiUrl);
            System.out.println("URL : " + apiUrl);
            System.out.println("Hard : "  + url);
            System.out.println("SecretCode : " + clientSecret);
            String message = sendMessageToChatBot(voiceMessage);
            System.out.println("### : " + message);

            String encodeBase64String = generateSignature(message, clientSecret);
            System.out.println("EncodeBase64String : " + encodeBase64String);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            System.out.println(con.getRequestProperties().toString());
            // Post request
            con.setDoOutput(true);
            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(message.getBytes(StandardCharsets.UTF_8)); // UTF-8로 인코딩하여 전송
                wr.flush();
            }
//            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
//            wr.write(message.getBytes("UTF-8"));
//            wr.flush();
//            wr.close();
            int responseCode = con.getResponseCode();
            System.out.println("Response Code : " + responseCode);

            if (responseCode == 200) { // Normal call
                System.out.println(con.getResponseMessage());

                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String decodedString = null;
//                System.out.println("INLINE : " + in.readLine());
                while ((decodedString = in.readLine()) != null) {
                    chatbotMessage = decodedString;
                    System.out.println("decodedString : " + decodedString);
                    System.out.println("chatbotMessage" + chatbotMessage);
                    return chatbotMessage;
                }
                in.close();
            } else {  // Error occurred
                chatbotMessage = "Error: " + con.getResponseMessage();
            }

        } catch (Exception e) {
            System.out.println(e);
            chatbotMessage = "Error occurred while communicating with the chatbot service.";
        }
        System.out.println("chatbotMessage" + chatbotMessage);
        return chatbotMessage;
    }
    private String generateSignature(String message, String secretKey){

        String encodeBase64String = "";

        try {
            byte[] secretKeyBytes = secretKey.getBytes(StandardCharsets.UTF_8);

            SecretKeySpec secretKeySpec = new SecretKeySpec(secretKeyBytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(secretKeySpec);

            byte[] rawHmac = mac.doFinal(message.getBytes(StandardCharsets.UTF_8));
            System.out.println("HMAC : " + rawHmac.toString());
            encodeBase64String = Base64.getEncoder().withoutPadding().encodeToString(rawHmac);
            System.out.println("encodeBase64String : " + encodeBase64String);

            return encodeBase64String;
        } catch (Exception e) {
            System.out.println(e);
        }
        return encodeBase64String;
    }


    public String sendMessageToChatBot(String voiceMessage) {

        String requestBody = "";
        try {

            JSONObject body = new JSONObject();
            long timestamp = new Date().getTime();

            body.put("version", "v2");
            //body.put("userId", UUID.randomUUID().toString());
            body.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
            body.put("timestamp", timestamp);

            JSONObject bubblesObject = new JSONObject();
            bubblesObject.put("type", "text");

            JSONObject dataObject = new JSONObject();
            String voiceMessageSafe = (voiceMessage != null) ? voiceMessage : "";
            dataObject.put("description", voiceMessageSafe);

            bubblesObject.put("data", dataObject);

            JSONArray bubblesArray = new JSONArray();
            bubblesArray.put(bubblesObject);

            body.put("bubbles", bubblesArray);
            body.put("event", "send");
            System.out.println("body origin : " + body);
            requestBody = body.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return "Error occurred while communicating with the chatbot service.";
        }
        return requestBody;
    }
}
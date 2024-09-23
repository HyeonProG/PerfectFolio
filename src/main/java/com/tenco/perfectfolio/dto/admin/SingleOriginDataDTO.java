package com.tenco.perfectfolio.dto.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class SingleOriginDataDTO {
    private int id;
    private String originJsonl;

    public String makeBeautifulJsonl() {
        //TODO : make beautiful
        // Gson을 사용하여 JSONL 데이터를 JsonObject로 파싱
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        JsonObject jsonObject = JsonParser.parseString(originJsonl).getAsJsonObject();
        // 포맷된 JSON 문자열로 출력
        return gson.toJson(jsonObject);
    }


}

package com.tenco.perfectfolio.repository.model.admin;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.tenco.perfectfolio.dto.admin.UsersCountByWeekDTO;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class UsersCountByWeekModel {

    private String date;
    private Integer signupCount;
    private Integer withdrawCount;

    public UsersCountByWeekDTO buildUsersCountByWeekDTO(){

        //날짜 -> 요일 변환(한글포맷)
        LocalDate localDate = LocalDate.parse(this.date);
        DayOfWeek dayOfWeek = localDate.getDayOfWeek();
        String day = dayOfWeek.getDisplayName(TextStyle.FULL, Locale.KOREAN);

        return UsersCountByWeekDTO.builder()
                .day(day)
                .signupCount(this.signupCount)
                .withdrawCount(this.withdrawCount * -1)
                .build();
    }
}

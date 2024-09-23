package com.tenco.perfectfolio.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ValidationCodeDTO {
    private String email;
    private String validationCode;
    private long expirationTime;

    /**
     *    !! expirationTime 의 단위
     *      1000 = 1초(sec)
     *      1000 * 60 = 1분(min)
     *      1000 * 60 * 3 = 3분
     *      180,000 = 3분
     */

    /**
     * 만약 현재 측정한 시간이 180,000(위 참고)를 초과한다면 true를 반환합니다.
     * @return boolean
     */
    public boolean isExpired(long currentTime, long sentTime, long expirationTime)  {
        return currentTime - sentTime > expirationTime;
        //       1724850380501   1724850560502
        // currentTime 은 시간이 지날수록 커진다 mil
    }

}

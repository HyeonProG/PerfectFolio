package com.tenco.perfectfolio.handler.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class DataFormatException extends RuntimeException {

    private HttpStatus status;

    public DataFormatException(String message, HttpStatus status) {
        super(message);
        this.status = status;
    }

}
package com.project.exception.kkb.handler;

import java.io.FileNotFoundException;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.project.exception.kkb.ErrorResult;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice(basePackages = "com.project.controller.kkb")
public class AdminAdvice {
		
	@ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResult exceptionHandler(Exception e) {
        log.error("[ExceptionHandler] message: {}, where: {}", e.getMessage(), e.getStackTrace()[0]);
        return new ErrorResult(e.getClass().getName(), "An unexpected error occurred.", "예기치 않은 오류가 발생했습니다.");
    }

	@ExceptionHandler(RuntimeException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public ErrorResult handleRuntimeException(RuntimeException e) {
	    log.error("[ExceptionHandler] RuntimeException: {}, where: {}", e.getMessage(), e.getStackTrace()[0]);
	    return new ErrorResult("RuntimeException", "A runtime error occurred.", "런타임 오류가 발생했습니다.");
	}
	
	@ExceptionHandler(DataAccessException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ErrorResult handleDataAccessException(DataAccessException e) {
	    log.error("[ExceptionHandler] DataAccessException: {}", e.getMessage(), e.getStackTrace()[0]);
	    return new ErrorResult("DataAccessException", "Data access error.", "데이터 액세스 오류 오류가 발생했습니다");
	}
	
	@ExceptionHandler(NullPointerException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ErrorResult handleNullPointerException(NullPointerException e) {
	    log.error("[ExceptionHandler] NullPointerException: {}", e.getMessage(), e.getStackTrace()[0]);
	    return new ErrorResult("NullPointerException", "Null reference error.", "Null 참조 오류가 발생했습니다.");
	}
	
	@ExceptionHandler(IllegalArgumentException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ErrorResult handleIllegalArgumentException(IllegalArgumentException e) {
	    log.error("[ExceptionHandler] IllegalArgumentException: {}", e.getMessage(), e.getStackTrace()[0]);
	    return new ErrorResult("IllegalArgumentException", "Invalid argument error.", "부적절한 인수 오류가 발생했습니다.");
	}

	@ExceptionHandler(FileNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public ErrorResult handleFileNotFoundException(FileNotFoundException e) {
	    log.error("[ExceptionHandler] FileNotFoundException: {}", e.getMessage(), e.getStackTrace()[0]);
	    return new ErrorResult("FileNotFoundException", "File not found.", "파일을 찾을 수 없습니다.");
	}

}

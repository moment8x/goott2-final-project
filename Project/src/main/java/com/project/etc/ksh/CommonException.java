package com.project.etc.ksh;


import java.io.IOException;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


//@ControllerAdvice	// 현재 클래스가 공통예외처리를 할 클래스임을 명시
public class CommonException {
	
//	@ExceptionHandler(IOException.class)	// 현재 메서드가 IOException에 대한 예외처리 함을 의미
//	public void ioException() {
//		
//	}
	@ExceptionHandler(Exception.class)	// 현재 메서드가 IOException에 대한 예외처리 함을 의미
	public String exceptionHandling(Exception e, Model model) {
		
		model.addAttribute("errorMsg", e.getMessage());
		model.addAttribute("errorStack", e.getStackTrace());
		
		return"/commonError";
	}
}

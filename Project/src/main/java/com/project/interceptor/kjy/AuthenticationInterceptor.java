package com.project.interceptor.kjy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 로그인 확인
		String uri = request.getRequestURI();
		System.out.println("uri? : " + uri);
		HttpSession session = request.getSession();
		switch (uri) {
		case "/pay": 
			
			break;

		default:
			break;
		}
		return super.preHandle(request, response, handler);
	}

}

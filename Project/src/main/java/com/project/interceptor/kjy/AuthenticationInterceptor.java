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
		String beforeUrl = request.getHeader("referer");
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") != null) {
			//여기에 switch문으로 url 비교해서 인가 확인 만들기
			response.sendRedirect("beforeUrl");
		}
		
		return super.preHandle(request, response, handler);
	}

}

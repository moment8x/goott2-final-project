package com.project.interceptor.kjy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class getBeforeLink extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		String BeforeUri = request.getHeader("referer");
		System.out.println("beforeUri : " + BeforeUri);
		return super.preHandle(request, response, handler);
	}

}

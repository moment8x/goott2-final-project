package com.project.interceptor.kjy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class PreviousPath extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		

//			if(uri.equals("http://localhost:8081/login/")) {
//				return "/index";
//			}
//			try {
//				response.sendRedirect(uri);
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		
//		Cookie[] cookies = request.getCookies();
//		for(Cookie cookie : cookies) {
//			if(cookie.getName().equals("al")) {
//				
//			}
//		}
		
		
		
		
		
		
		// 이전 경로 얻어오는 인터셉터 (단 링크에 직접 입력한 사람의 경로는 얻어오지 못함)
		String ref = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", ref);
		return super.preHandle(request, response, handler);
	}
	
}

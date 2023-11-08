package com.project.interceptor.kjy;

import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.dao.kjr.LoginDao;
import com.project.vodto.kjy.Memberkjy;


public class RememberInterceptor extends HandlerInterceptorAdapter {
	
	@Inject
	private LoginDao lDao;

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(request.getMethod().equals("POST") && request.getRequestURI().equals("/login/")) {
			String remember = request.getParameter("remember");
			Memberkjy member = (Memberkjy) request.getSession().getAttribute("loginMember");
			String member_id = member.getMember_id();
			if(remember != null && remember.equals("on")) {
				String key = getUUID();
				int temp1 = lDao.updateRemember(member_id, key);
				if(temp1 == 1) {
					// 암호화?? 토큰 발행?? 고민중.. -> 시큐리티
					String CookieVal = member_id +"/a@"+ key;
					Cookie cookie = new Cookie("remCo", CookieVal);
					cookie.setMaxAge(60 * 60 * 24 * 365);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}
		
		super.postHandle(request, response, handler, modelAndView);
	}
	
	public String getUUID() {
		String uuid = UUID.randomUUID().toString().substring(0, 10);
		return uuid;
	}
	
}

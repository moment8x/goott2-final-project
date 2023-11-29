package com.project.interceptor.kjy;

import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.dao.kjy.LoginDao;
import com.project.service.kjy.LoginService;
import com.project.vodto.kjy.Memberkjy;

public class RememberInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private LoginService loginService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 자동로그인 여부 체크후 적용
		if(request.getMethod().equals("GET") && request.getRequestURI().equals("/login/")) {
			Cookie[] cookies = request.getCookies();
			String value = "";
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					if("remCo".equals(cookie.getName())) {
						value = cookie.getValue();
						String member_id = value.split("/a@")[0];
						String key = value.split("/a@")[1];
						try {
							Memberkjy loginMember = loginService.getRememberCheck(member_id, key);
							if(loginMember != null) {
								request.getSession().setAttribute("loginMember", loginMember);
								System.out.println("자동로그인!!");
								response.sendRedirect("/");
							}
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
				
				
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (request.getMethod().equals("POST") && request.getRequestURI().equals("/login/")) {
			String remember = request.getParameter("remember");
			if (request.getSession().getAttribute("loginMember") != null) {
				Memberkjy member = (Memberkjy) request.getSession().getAttribute("loginMember");
				String memberId = member.getMemberId();
				if (remember != null && remember.equals("on")) {
					String key = getUUID();
					boolean temp1 = loginService.saveRemember(memberId, key);
					if (temp1) {
						// 암호화?? 토큰 발행?? 고민중.. -> 시큐리티
						String CookieVal = memberId + "/a@" + key;
						Cookie cookie = new Cookie("remCo", CookieVal);
						cookie.setMaxAge(60 * 60 * 24 * 365);
						cookie.setPath("/");
						response.addCookie(cookie);
					}
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

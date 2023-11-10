package com.project.interceptor.kjs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.etc.kjs.SessionCheck;
import com.project.vodto.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("================== 로그인 PreHandle 시작 ==================");
		boolean result = false;
		// 로그인 유무 검사
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			//로그인을 했을 시
			System.out.println("로그인되어있어!");
			result = true;
		} else {
			//로그인을 안했을 시
			System.out.println("로그인 안했어!");
			String history = request.getHeader("referer");
			history = history.substring(history.indexOf("/") + 2);
			history = history.substring(history.indexOf("/"));
			System.out.println("history path : " + history);
			session.setAttribute("returnPath", history);
			
			response.sendRedirect(history);
		}
		
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("================ LoginInterceptor - postHandle() ================");
		
		HttpSession session = request.getSession();
		
		ModelMap modelMap = modelAndView.getModelMap();
		Member loginMember = (Member)modelMap.get("loginMember");
		
		// 로그인을 성공했다면 session에 로그인 기록을 남김
		if (loginMember != null) {
			System.out.println(loginMember.toString());
			session.setAttribute("loginMember", loginMember);	// 로그인 기록 세션에 남기기
			
			System.out.println("현재 로그인한 유저 : " + loginMember.getMemberId() + ", 세션 ID : " + session.getId());
			
			// 로그인 시 세션 key 값을 로그인한 유저 아이디로 교체
			// 중복 로그인(기존 로그인 정보 지우고, 새 로그인 정보 삽입)
			SessionCheck.replaceSessionKey(session, loginMember.getMemberId());
			
			String returnPath = "";
			if (session.getAttribute("returnPath") != null) {
				returnPath = (String)session.getAttribute("returnPath");
			}
			
			// 로그인 하지 않은 상태로 게시판(글작성/수정/삭제)에 접근 했을 경우 이전 경로로.
			// 이전 경로가 없을 때 로그인 했다면 /로
			response.sendRedirect(!returnPath.equals("") ? returnPath : "/");
		}
	}
	
}
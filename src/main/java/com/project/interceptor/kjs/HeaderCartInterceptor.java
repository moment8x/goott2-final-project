package com.project.interceptor.kjs;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.project.service.kjs.member.non.NonMemberService;
import com.project.service.kjs.shoppingcart.ShoppingCartService;
import com.project.vodto.ShoppingCart;

public class HeaderCartInterceptor extends HandlerInterceptorAdapter {
	@Inject
	NonMemberService nmsService;
	@Inject
	ShoppingCartService scService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("HeaderCartInterceptor - preHandle 시작");
		// 로그인 상태 확인.
		// 로그인 했을 시
		// 회원 장바구니 정보 불러오기
		
		// 로그인 상태가 아닐 시
		// 비회원 쿠키가 있는지 확인
		Cookie cookie = WebUtils.getCookie(request, "nom");
		System.out.println("비회원cookie null check : " + cookie);
		if (cookie != null) {
			// 비회원 쿠키가 있다면 장바구니 정보 불러오기
			System.out.println("비회원 장바구니 정보 불러오기");
			Map<String, Object> mapList = scService.getShoppingCart(cookie.getValue(), false);
			List<ShoppingCart> list = (List<ShoppingCart>)mapList.get("list");
			if (list.size() > 0) {
				// 리스트에 내용물이 들어있는 경우(장바구니 아이콘에 list.size() 출력)
			} else {
				// 리스트가 비어있는 경우(장바구니 아이콘에 표시X)
			}
			
		} else {
			// 비회원 쿠키가 없다면 비회원 쿠키 저장
			System.out.println("비회원 쿠키 저장");
			HttpSession session = request.getSession();	// 세션 값 받기
			String sessionValue = session.getId();	// 세션ID
			Timestamp sessionLimit = new Timestamp(System.currentTimeMillis() + (1000 * 60 * 60 * 24 * 7));	// DB에 저장할 값
			
			cookie = new Cookie("nom", sessionValue);	// [key, value] : [nom, sessionValue]의 쿠키 생성
			cookie.setMaxAge(1000 * 60 * 60 * 24);	// 쿠키의 유효기간 설정(1일)
			cookie.setPath("/");	// 쿠키가 적용될 경로 지정
			// 비회원 쿠키를 DB에 저장
			if (nmsService.saveNonMemberId(sessionValue, sessionLimit)) {
				System.out.println("비회원 쿠키 DB에 저장");
				response.addCookie(cookie);	// response로 클라이언트에 보내서 쿠키 저장
			}
		}
		
		System.out.println("HeaderCartInterceptor - preHandle의 끝");
		
		return true;
	}
	
}
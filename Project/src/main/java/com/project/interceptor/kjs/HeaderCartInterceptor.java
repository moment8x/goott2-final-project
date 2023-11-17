package com.project.interceptor.kjs;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.project.service.kjs.member.non.NonMemberService;
import com.project.service.kjs.shoppingcart.ShoppingCartService;
import com.project.vodto.kjs.ShowCartDTO;
import com.project.vodto.kjy.Memberkjy;

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
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") == null) {
			// 로그인 상태가 아닐 시
			// 비회원 쿠키가 있는지 확인
			Cookie cookie = WebUtils.getCookie(request, "nom");
			if (cookie == null) {
				// 비회원 쿠키가 없다면 비회원 쿠키 저장
				String sessionValue = session.getId();	// 세션ID
				Timestamp sessionLimit = new Timestamp(System.currentTimeMillis() + (1000 * 60 * 60 * 24 * 7));	// DB에 저장할 값
				
				cookie = new Cookie("nom", sessionValue);	// [key, value] : [nom, sessionValue]의 쿠키 생성
				cookie.setMaxAge(1000 * 60 * 60 * 24);	// 쿠키의 유효기간 설정(1일)
				cookie.setPath("/");	// 쿠키가 적용될 경로 지정
				// 비회원 쿠키를 DB에 저장
				if (nmsService.saveNonMemberId(sessionValue, sessionLimit)) {
					response.addCookie(cookie);	// response로 클라이언트에 보내서 쿠키 저장
				}
			}
		}
		
		System.out.println("HeaderCartInterceptor - preHandle의 끝");
		
		return true;
	}


	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("HeaderCartInterceptor - postHandle 시작");
		
		// header의 장바구니 관련 처리
		List<ShowCartDTO> items = null;
		// 장바구니 리스트 출력. 필요 내용 : (비)회원 아이디, 상품코드, 상품 이미지, 상품명, 상품 판매가
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			// 로그인 했을 시
			if (scService.countList(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true) > 0) {
				items = scService.getCartList(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true);
			}
		} else {
			// 비회원일 시
			Cookie cookie = WebUtils.getCookie(request, "nom");
			if (scService.countList(cookie.getValue(), false) > 0) {
				items = scService.getCartList(cookie.getValue(), false);
			}
		}
		
		if (items != null) {
			session.setAttribute("cartItems", items);
		} else {
			session.setAttribute("cartItems", "none");
		}
		
		System.out.println("HeaderCartInterceptor - postHandle 끝");
	}
	
}
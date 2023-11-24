package com.project.interceptor.kjy;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.vodto.kjy.Memberkjy;

public class orderInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		String orderId = "";
		String impKey = "imp77460302";
//		System.out.println("?????"+request.getParameter("isLogin"));
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			System.out.println("상희쿤");
	         orderId = "O" + new Date().getTime();
	         
	      } else {
	    	  orderId = "N" + new Date().getTime();
	         
	      }
		System.out.println("야야야야야야" + orderId);
		request.setAttribute("orderId", orderId);
		request.setAttribute("impKey", impKey);
		
		return super.preHandle(request, response, handler);
	}

}

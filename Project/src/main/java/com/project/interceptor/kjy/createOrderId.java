package com.project.interceptor.kjy;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class createOrderId extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		String orderId = "";
//		System.out.println("?????"+request.getParameter("isLogin"));
		if (request.getParameter("isLogin") != null && request.getParameter("isLogin").equals("N") ) {
	         orderId = "N" + new Date().getTime();
	         
	      } else {
	         orderId = "O" + new Date().getTime();
	         
	      }
		request.setAttribute("orderId", orderId);
		
		return super.preHandle(request, response, handler);
	}

}

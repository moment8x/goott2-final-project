package com.project.controller.ksh;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.vodto.NonOrderHistory;

@Controller
@RequestMapping(value = "/order/*")
public class OrderController {
	
	// 회원인지 비회원인지 조회
	public void identifyMember() {
		// 회원 주문 페이지 or 비회원 주문 페이지 or 로그인 창 띄우기
		
	}
	
	@RequestMapping(value = "memberOrder", method = RequestMethod.GET)
	public String memberOrder() {
		return "/order/memberOrder";
	}
	
	@RequestMapping(value = "nonMemberOrder", method = RequestMethod.GET)
	public void nonMemberOrder(Model model) {
		//return "/order/nonMemberOrder";
		model.addAttribute("impKey", "imp77460302");
	}
	
	@RequestMapping(value = "products", method = RequestMethod.GET)
	public void getProducts() {
		
	}
	
	@RequestMapping(value = "orderComplete", method = RequestMethod.POST)
	public void orderComplete(NonOrderHistory noh) {
		
		// 비회원 주문 결제 완료하고 주문 내역 창 띄우기
		
		System.out.println("결제 완료하고 다음 페이지 띄우기");
//		noh.setNon_member_id("test_non_member");
//		System.out.println(noh.toString());
		
	}
	
}

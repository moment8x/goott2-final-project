package com.project.controller.jmj;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.member.MemberService;
import com.project.vodto.Member;

@Controller
@RequestMapping("/user/*")
public class myPageController {
	
	@Inject
	private MemberService mService;
	
	@RequestMapping("myPage")
	public void myPage() {
		System.out.println("마이페이지");
	}
	
	@RequestMapping("address")
	public void addr() {
		System.out.println("배송지 목록");
	}
	
	@RequestMapping("jusoPopup")
	public void findAddr() {
		System.out.println("주소 검색");
	}
	
	@RequestMapping("orderList")
	public void getOrderList(String memberId) {
		System.out.println("주문 내역");
		
		try {
			mService.getOrderHistory(memberId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

@Controller
@RequestMapping("/user/*")
public class myPageController {
	
	@Inject
	private MemberService mService;
	
	@RequestMapping("myPage")
	public void myPage(Model model) {
		
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
	public void getOrderList(Model model, HttpServletRequest req) {
		
		System.out.println("주문 내역");
		String memberId = "abc1234";
		String orderNo = req.getParameter("orderNo");
		System.out.println(orderNo);
		
		try {
//			List<Integer> list = mService.getOrderNo(memberId);
			List<MyPageOrderList> lst = mService.getOrderHistory(memberId);
//			List<Integer> orderNo = mService.getOrderNo(memberId);
//			int result = mService.getOrderProductCount(orderNo);
			
			System.out.println("list : " + lst);
//			System.out.println(orderNo);
			model.addAttribute("orderList", lst);
			
//			model.addAttribute("orderProductCount", result);
//			System.out.println(lst);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	@RequestMapping("detailOrderList")
	public void getDetailOrderList() {
		System.out.println("주문 상세 내역");
	}
}
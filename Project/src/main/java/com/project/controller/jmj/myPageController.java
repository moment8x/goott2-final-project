
package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

import okhttp3.ResponseBody;

@Controller
@RequestMapping("/user/*")
public class myPageController {
	
	@Inject
	private MemberService mService;
	
	@RequestMapping("myPage")
	public void myPage(Model model) {
		
		System.out.println("마이페이지");
		System.out.println("주문 내역");
		String memberId = "abc1234";
		
//		System.out.println(orderListNo);

		List<MyPageOrderList> lst= null;
		
		try {
			lst = mService.getOrderHistory(memberId);
			Member userInfo = mService.getMyInfo(memberId);

			System.out.println("list : " + lst);
			model.addAttribute("orderList", lst);
			
			System.out.println(userInfo);
			model.addAttribute("userInfo", userInfo);
			
//			int result = mService.getOrderProductCount(orderNo);
//			List<Integer> list = mService.getOrderNo(memberId);
//			System.out.println(orderNo);
//			model.addAttribute("orderProductCount", result);
//			System.out.println(lst);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
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
		
		
	}
	
	@RequestMapping("detailOrderList")
	public void getDetailOrderList() {
		System.out.println("주문 상세 내역");
	}
	
	@RequestMapping("userInfo")
	public void checkPwd() {
		System.out.println("비밀번호 확인");
	}
	
	@RequestMapping(value = "userInfoModify", method = RequestMethod.POST)
	public void modifyUserInfo(Model model) {
		System.out.println("회원 정보 수정");
		String memberId = "abc1234";
		try {
			Member userInfo = mService.getMyInfo(memberId);
			System.out.println(userInfo);
			model.addAttribute("userInfo", userInfo);
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "sendMail", method = RequestMethod.POST)
	public ResponseEntity<String> sendMail(String newEmail){
		String code = UUID.randomUUID().toString();
		
		System.out.println(newEmail + " 로 " + code + " 전송");
		
		
		return null;
	}

}
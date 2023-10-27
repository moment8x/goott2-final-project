
package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

@Controller
@RequestMapping("/user/*")
public class myPageController {

	@Inject
	private MemberService mService;

	@RequestMapping(value = "myPage")
	public void myPage(Model model) {

		System.out.println("마이페이지");
		String memberId = "ahong53";

//		System.out.println(orderListNo);

//		List<MyPageOrderList> lst = null;

		try {
//			lst = mService.getOrderHistory(memberId);
			Member userInfo = mService.getMyInfo(memberId);

//			System.out.println("list : " + lst);
//			model.addAttribute("orderList", lst);

			System.out.println(userInfo);
			model.addAttribute("userInfo", userInfo);

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

	@RequestMapping("userInfoModify")
	public void userInfoModify() {
		System.out.println("회원정보");
	}

	@RequestMapping(value = "validEamil", method = RequestMethod.POST)
	public @ResponseBody boolean sendMail(@RequestParam("tmpEmail") String email) {
		System.out.println("이메일 중복검사");
		
		boolean result = false;
		
		try {
			Member newEmail = mService.duplicateUserEmail(email);
			System.out.println(newEmail);
			
			if(newEmail != null) {//이메일이 중복
				result = true;
			}

		} catch (SQLException | NamingException e) {

			e.printStackTrace();
		}

		return result;

	}

}
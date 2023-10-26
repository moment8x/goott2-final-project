
package com.project.controller.jmj;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.etc.SendMail;
import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

@Controller
@RequestMapping("/user/*")
public class myPageController {

	@Inject
	private MemberService mService;

	@Autowired
	JavaMailSenderImpl mailSender;

	@RequestMapping(value = "myPage")
	public void myPage(Model model) {

		System.out.println("마이페이지");
		String memberId = "abc1234";

//		System.out.println(orderListNo);

		List<MyPageOrderList> lst = null;

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


	@RequestMapping(value = "sendMail", method = RequestMethod.POST)
	public @ResponseBody Member sendMail(@RequestParam("tmpEmail") String email) {
		System.out.println("이메일 중복검사");
		Member newEmail  = null;
		try {
			 newEmail = mService.duplicateUserEmail(email);
			System.out.println(newEmail);

		} catch (SQLException | NamingException e) {

			e.printStackTrace();
		}

		return newEmail;

	}

}
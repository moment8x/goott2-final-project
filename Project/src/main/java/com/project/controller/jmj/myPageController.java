
package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;
import com.project.vodto.ShippingAddress;

@Controller
@RequestMapping("/user/*")
public class myPageController {

	@Inject
	private MemberService mService;

	@RequestMapping(value = "myPage")
	public void myPage(Model model) {

		System.out.println("마이페이지");
		String memberId = "agim79";

//		System.out.println(orderListNo);

//		List<MyPageOrderList> lst = null;

		try {
//			lst = mService.getOrderHistory(memberId);
//			mService.getShippingAddress(memberId);
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

	@RequestMapping(value = "myPage", method = RequestMethod.POST)
	public void myPage(@ModelAttribute ShippingAddress addShippingAddress) {
		System.out.println(addShippingAddress.toString());
	}
	
	@RequestMapping("address")
	public void deliveryList() {
		
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

	@RequestMapping(value = "identityVerificationStatus", method = RequestMethod.POST)
	public @ResponseBody boolean identityVerificationStatus() {
		System.out.println("본인인증 업데이트");
		String memberId = "agim79";
		
		boolean result = false;
		try {
			int identityVerificationStatus = mService.updateAuthentication(memberId);
			
			if(identityVerificationStatus == 1) {
				result = true;
			}
			
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "duplicateUserEmail", method = RequestMethod.POST)
	public @ResponseBody boolean duplicateUserEmail(@RequestParam("tmpEmail") String email) {
		
		boolean result = false;
		
		try {
			Member newEmail = mService.duplicateUserEmail(email);
			System.out.println("이메일 중복 검사" + newEmail);
			
			if(newEmail != null) {//이메일이 중복
				result = true;
			}

		} catch (SQLException | NamingException e) {

			e.printStackTrace();
		}

		return result;

	}
	
	@RequestMapping(value = "duplicatePhoneNumber", method = RequestMethod.POST)
	public @ResponseBody boolean duplicatePhoneNumber(@RequestParam("newPhoneNumber") String phoneNumber) {
		
		boolean result = false;
		
		try {
			Member newPhoneNumber = mService.duplicatePhoneNumber(phoneNumber);
			System.out.println("전화번호 중복 검사" + newPhoneNumber);
			
			if(newPhoneNumber != null) { //전화번호 중복
				result = true;
			}
		} catch (SQLException | NamingException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "duplicateCellPhone", method = RequestMethod.POST)
	public @ResponseBody boolean duplicateCellPhone(@RequestParam("newCellPhone") String cellPhoneNumber) {
		
		boolean result  = false;
		
		try {
			Member newCellPhoneNumber = mService.duplicateCellPhone(cellPhoneNumber);
			System.out.println("휴대폰번호 중복검사" + newCellPhoneNumber);
			if(newCellPhoneNumber != null) {//휴대폰번호 중복검사
				result = true;
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "modifyUser", method = RequestMethod.POST)
	public void modifyUserInfo(@ModelAttribute Member modifyMemberInfo) {
		System.out.println("회원정보 수정");
		
		String memberId = "agim79";
		
		try {
			boolean userInfo = mService.setMyInfo(memberId, modifyMemberInfo);
			if(userInfo) {
				System.out.println("회원정보 수정완료");
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(modifyMemberInfo.toString());
	}
	
	@RequestMapping(value = "withdrawal")
	public void deleteUser() {
		System.out.println("탈퇴하러 가기");

	}

	@RequestMapping(value = "withdrawal", method = RequestMethod.POST)
	public void withdrawMember() {
		
		String memberId = "agim79";
		
		System.out.println(memberId + " 탈퇴시도");
		
		try {
			boolean delUser = mService.withdraw(memberId);
			if(delUser) {
				System.out.println(memberId + "탈퇴 완");
				//로그아웃처리해야함
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	@RequestMapping(value = "addShippingAddress", method = RequestMethod.POST)
	public @ResponseBody boolean addShippingAddress(@ModelAttribute ShippingAddress tmpAddr) {
		System.out.println("배송지 추가" + tmpAddr.toString());
		String memberId = "agim79";
		boolean result = false;
		try {
			if(mService.insertShippingAddress(memberId, tmpAddr)) {
				System.out.println("배송지 추가 완료");
				result = true;
			}
			
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

}

package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;
import com.project.vodto.ShippingAddress;
import com.project.vodto.kjy.Memberkjy;

@Controller
@RequestMapping("/user/*")
public class myPageController {

	@Inject
	private MemberService mService;

	@RequestMapping(value = "myPage")
	public void myPage(Model model, HttpServletRequest request) {

		System.out.println("마이페이지");

		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();
//		System.out.println(orderListNo);

//		List<MyPageOrderList> lst = null;

		try {
//			lst = mService.getOrderHistory(memberId);
			Member userInfo = mService.getMyInfo(memberId);
			model.addAttribute("userInfo", userInfo);
			System.out.println("회원정보 : " + userInfo);

//			System.out.println("list : " + lst);
//			model.addAttribute("orderList", lst);

			List<ShippingAddress> userAddrList = mService.getShippingAddress(memberId);
			model.addAttribute("userAddrList", userAddrList);

			System.out.println("배송주소록" + userAddrList);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "myPage", method = RequestMethod.POST)
	public void myPage(@ModelAttribute ShippingAddress addShippingAddress) {
		System.out.println(addShippingAddress.toString());
	}

	@RequestMapping(value = "myPage/modifyShippingAddr", method = RequestMethod.POST)
	public ResponseEntity<ShippingAddress> modifyShippingAddr(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		System.out.println("배송지 수정");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		ResponseEntity<ShippingAddress> result = null;
		
		Object addrSeqObj = map.get("addrSeq");

		if (addrSeqObj != null) {
			try {
				// String을 int로 변환
				int addrSeq = Integer.parseInt((String) addrSeqObj);

				ShippingAddress sa = mService.getShippingAddr(addrSeq, memberId);
				System.out.println(addrSeq + "번 배송지를 수정하자!@ " + sa.toString());
				result = new ResponseEntity<ShippingAddress>(sa, header, HttpStatus.OK);

			} catch (NumberFormatException e) {
				System.out.println("예외남 : " + addrSeqObj);
				
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		}else {
		    // addrSeqObj가 null인 경우
		    System.out.println("addrSeq null");
		}
		
		return result;
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
	public @ResponseBody boolean identityVerificationStatus(HttpServletRequest request) {
		System.out.println("본인인증 업데이트");
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		boolean result = false;
		try {
			int identityVerificationStatus = mService.updateAuthentication(memberId);

			if (identityVerificationStatus == 1) {
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

			if (newEmail != null) {// 이메일이 중복
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

			if (newPhoneNumber != null) { // 전화번호 중복
				result = true;
			}
		} catch (SQLException | NamingException e) {

			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "duplicateCellPhone", method = RequestMethod.POST)
	public @ResponseBody boolean duplicateCellPhone(@RequestParam("newCellPhone") String cellPhoneNumber) {

		boolean result = false;

		try {
			Member newCellPhoneNumber = mService.duplicateCellPhone(cellPhoneNumber);
			System.out.println("휴대폰번호 중복검사" + newCellPhoneNumber);
			if (newCellPhoneNumber != null) {// 휴대폰번호 중복검사
				result = true;
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}

		return result;
	}

	@RequestMapping(value = "modifyUser", method = RequestMethod.POST)
	public void modifyUserInfo(@ModelAttribute Member modifyMemberInfo, HttpServletRequest request) {
		System.out.println("회원정보 수정");
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		try {
			boolean userInfo = mService.setMyInfo(memberId, modifyMemberInfo);
			if (userInfo) {
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
	public String withdrawMember(HttpServletRequest request) {

		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		System.out.println(memberId + " 탈퇴시도");

		try {
			boolean delUser = mService.withdraw(memberId);
			if (delUser) {
				System.out.println(memberId + "탈퇴 완");
				session.removeAttribute("loginMember");
				session.invalidate();
				System.out.println("로그아웃 완");
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/";

	}

	@RequestMapping(value = "addShippingAddress", method = RequestMethod.POST)
	public @ResponseBody boolean addShippingAddress(@ModelAttribute ShippingAddress tmpAddr,
			HttpServletRequest request) {
		System.out.println("배송주소록 추가" + tmpAddr.toString());
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		boolean result = false;
		try {
			if (mService.insertShippingAddress(memberId, tmpAddr)) {
				System.out.println("배송지 추가 완료");
				result = true;
			}

		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping("editShippingAddr")
	public void editShippingAddr(@RequestParam("addrSeq") int addrSeq, HttpServletRequest request, Model model) {
		System.out.println(addrSeq + "번 배송지를 수정하자");

		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		ShippingAddress sa = mService.getShippingAddr(addrSeq, memberId);
		model.addAttribute("memberShippingAddr", sa);

	}

	@RequestMapping(value = "shippingAddrModify", method = RequestMethod.POST)
	public void shippingAddrModify(@ModelAttribute ShippingAddress tmpAddr, HttpServletRequest request) {
		System.out.println("배송주소록 수정" + tmpAddr.toString());
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMember_id();

		try {

			if (mService.shippingAddrModify(memberId, tmpAddr)) {
				System.out.println("배송주소록 수정 완");
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
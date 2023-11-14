
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.ShippingAddress;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetBankTransfer;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageOrderList;
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
		String memberId = member.getMemberId();

		try {
			//주문내역
			List<MyPageOrderList> lst = mService.getOrderHistory(memberId);
			model.addAttribute("orderList", lst);			
			System.out.println("주문내역 페이지 : " + lst);
			
			//최근 주문내역
			List<MyPageOrderList> list = mService.getCurOrderHistory(memberId);
			model.addAttribute("curOrderHistory", list);			
			System.out.println("최근주문내역 : " + list);
			
			
			//회원정보
			Member userInfo = mService.getMyInfo(memberId);
			model.addAttribute("userInfo", userInfo);			

			//배송주소록
			List<ShippingAddress> userAddrList = mService.getShippingAddress(memberId);
			model.addAttribute("userAddrList", userAddrList);
			
			//주문상태별 갯수
			mService.getOrderStatusCnt();
			
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
		String memberId = member.getMemberId();

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

			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
				
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		}else {
		    // addrSeqObj가 null인 경우
		    System.out.println("addrSeq null");
		}
		
		return result;
	}
	
	@RequestMapping(value = "shippingAddrModify", method = RequestMethod.POST)
	public ResponseEntity<ShippingAddress> shippingAddrModify(@ModelAttribute ShippingAddress tmpAddr, HttpServletRequest request, @RequestParam Map<String, Object> map) {
		System.out.println("배송주소록 수정" + tmpAddr.toString());
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		Object addrSeqObj = map.get("addrSeq");

		ResponseEntity<ShippingAddress> result = null;
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		if (addrSeqObj != null) {
			try {
				// String을 int로 변환
				int addrSeq = Integer.parseInt((String) addrSeqObj);

				ShippingAddress sa = mService.getShippingAddr(addrSeq, memberId);
				System.out.println(addrSeq + "번 배송지를 수정하자!@ " + sa.toString());
				
				if (mService.shippingAddrModify(memberId, tmpAddr, addrSeq)) {
					System.out.println("배송주소록 수정 완");
					result = new ResponseEntity<ShippingAddress>(tmpAddr, header, HttpStatus.OK);
				}
			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		}else {
		    // addrSeqObj가 null인 경우
		    System.out.println("addrSeq null");
		    result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
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
	
	@RequestMapping("pwdCheck")
	public void pwdCheck() {
		System.out.println("비밀번호 확인");
	}

	@RequestMapping(value = "identityVerificationStatus", method = RequestMethod.POST)
	public @ResponseBody boolean identityVerificationStatus(HttpServletRequest request) {
		System.out.println("본인인증 업데이트");
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

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
		String memberId = member.getMemberId();

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
	public ResponseEntity<String> withdrawMember(HttpServletRequest request, @RequestParam("password") String password) {

		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		System.out.println(memberId + " 탈퇴시도");
		
		ResponseEntity<String> result = null;

		try {
			boolean delUser = mService.withdraw(memberId, password);
			if (delUser) {
				System.out.println(memberId + "탈퇴 완");
				session.removeAttribute("loginMember");
				session.invalidate();
				System.out.println("로그아웃 완");
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}

	@RequestMapping(value = "addShippingAddress", method = RequestMethod.POST)
	public @ResponseBody boolean addShippingAddress(@ModelAttribute ShippingAddress tmpAddr,
			HttpServletRequest request) {
		System.out.println("배송주소록 추가" + tmpAddr.toString());
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

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

	@RequestMapping(value = "deleteShippingAddr", method = RequestMethod.POST)
	public void deleteShippingAddr(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		Object addrSeqObj = map.get("addrSeq");

		if (addrSeqObj != null) {
			try {
				// String을 int로 변환
				int addrSeq = Integer.parseInt((String) addrSeqObj);

				int delAddr = mService.deleteShippingAddr(memberId, addrSeq);
				System.out.println(addrSeq + "번 배송지를 삭제하자! ");
				
				if (mService.deleteShippingAddr(memberId, addrSeq) == 0) {
					System.out.println("배송주소록 삭제 완");;
				}
			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
			}
		}else {
		    // addrSeqObj가 null인 경우
		    System.out.println("addrSeq null");
		}
	}
	
	@RequestMapping(value = "setBasicAddr", method = RequestMethod.POST)
	public ResponseEntity<String> setBasicAddr(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		ResponseEntity<String> result = null;
		
		Object addrSeqObj = map.get("addrSeq");

		if (addrSeqObj != null) {
			try {
				// String을 int로 변환
				int addrSeq = Integer.parseInt((String) addrSeqObj);
				
				if(mService.setBasicAddr(memberId, addrSeq)) {
					System.out.println(addrSeq + "번 배송지가 기본배송지로 바뀌었습니다.");
					result = new ResponseEntity<String>("success", HttpStatus.OK);
				}
				
			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		}else {
		    // addrSeqObj가 null인 경우
		    System.out.println("addrSeq null");
		    result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}
	
	@RequestMapping("orderDetail")
	public void orderDetail(@RequestParam("no") String orderNo, HttpServletRequest request, Model model) {
		System.out.println("주문상세페이지입니당.");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		Map<String, Object> result = null;
		
		try {
			//주문상품 상세정보
			List<DetailOrder> detailOrder = mService.getDetailOrderInfo(memberId, orderNo);
			model.addAttribute("detailOrderInfo", detailOrder);
			System.out.println("주문상품상세정보!!!!!" + detailOrder.toString());
			

			Map<String, Object>  map = mService.getOrderInfo(memberId, orderNo);
			//주문상세정보
			DetailOrderInfo detailOrderInfo = (DetailOrderInfo)map.get("detailOrderInfo");
			//쿠폰사용내역
			List<CouponHistory> couponHistory = (List<CouponHistory>)map.get("couponsHistory");
			//무통장 결제내역
			GetBankTransfer bankTransfer = (GetBankTransfer)map.get("bankTransfer");
			
			model.addAttribute("detailOrder", detailOrderInfo);
			model.addAttribute("couponHistory", couponHistory);
			model.addAttribute("bankTransfer", bankTransfer);
			
			//배송주소록
			List<ShippingAddress> userAddrList = mService.getShippingAddress(memberId);
			 model.addAttribute("userAddrList", userAddrList);
			
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value ="orderDetail", method = RequestMethod.POST )
	public void orderDetailPost() {
		System.out.println("상세페이지");
	}
	
	@RequestMapping(value = "editDeliveryAddress", method = RequestMethod.POST)
	public ResponseEntity<String> editDeliveryAddress(@ModelAttribute DetailOrderInfo updateDetailOrderAddr, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
	
		ResponseEntity<String> result = null;
		
		try {
			if(mService.updateDetailOrderAddr(updateDetailOrderAddr, memberId)) {
				System.out.println("배송지 변경 완");
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "selectBasicAddr", method = RequestMethod.POST)
	public ResponseEntity<String> getBasicAddrList(HttpServletRequest request, @RequestParam("addrSeq") int addrSeq, @RequestParam("deliveryMessage") String deliveryMessage, 
		 @RequestParam("orderNo") String orderNo) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
	
		ResponseEntity<String> result = null;

		try {
			if(mService.selectBasicAddr(memberId, addrSeq, orderNo, deliveryMessage)) {
				System.out.println("배송지 변경 완");
				result = new ResponseEntity<String>("success",HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}
	
	@RequestMapping(value = "searchOrderStatus", method = RequestMethod.POST)
	public ResponseEntity<List<MyPageOrderList>> searchOrderStatus(@ModelAttribute GetOrderStatusSearchKeyword keyword, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		System.out.println("키워드@@@@@@@@@@@@@@@@@@@@@@@"+keyword.toString());

		ResponseEntity<List<MyPageOrderList>> result = null;
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		try {
			List<MyPageOrderList> sos = mService.searchOrderStatus(memberId, keyword);
			if(sos != null) {
				result = new ResponseEntity<List<MyPageOrderList>>(sos, header, HttpStatus.OK);				
			}else {
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} catch (SQLException | NamingException e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
}
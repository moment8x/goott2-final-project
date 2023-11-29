
package com.project.controller.jmj;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.filters.ExpiresFilter.XHttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.etc.jmj.UploadProfileFileProcess;
import com.project.service.kjy.ListService;
import com.project.service.member.MemberService;
import com.project.vodto.CouponLog;
import com.project.vodto.Member;
import com.project.vodto.PointLog;
import com.project.vodto.RewardLog;
import com.project.vodto.ShippingAddress;
import com.project.vodto.UploadFiles;
import com.project.vodto.jmj.CancelDTO;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetBankTransfer;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageCouponLog;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.jmj.PagingInfo;
import com.project.vodto.jmj.ReturnOrder;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.jmj.exchangeDTO;
import com.project.vodto.jmj.MyPageReview;
import com.project.vodto.kjy.Memberkjy;

@Controller
@RequestMapping("/user/*")
public class myPageController {

	@Inject
	private MemberService mService;
	
	@Inject 
	private ListService lService;
	
	private UploadFiles uf;

	private List<UploadFiles> fileList = new ArrayList<UploadFiles>();
	
	@RequestMapping(value = "myPage")
	public void myPage(Model model, HttpServletRequest request, @RequestParam(value = "pageNo", defaultValue = "1")int pageNo) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		
		if(member != null) {
			String memberId = member.getMemberId();
			System.out.println("@@@@@@@@@@@@@페이지번호 : " + pageNo);
			try {
				// 주문내역
				Map<String, Object> map = mService.memberInfo(memberId, pageNo);
				
				List<MyPageOrderList> lst = (List<MyPageOrderList>) map.get("orderHistory");
				PagingInfo pi = (PagingInfo) map.get("pagination");
				
				model.addAttribute("orderList", lst);
				model.addAttribute("page", pi);
				
				// 최근 주문내역
				List<MyPageOrderList> list = mService.getCurOrderHistory(memberId);
				model.addAttribute("curOrderHistory", list);
				
				// 회원정보
				Member userInfo = mService.getMyInfo(memberId);
				model.addAttribute("userInfo", userInfo);
				
				// 배송주소록
				List<ShippingAddress> userAddrList = mService.getShippingAddress(memberId);
				model.addAttribute("userAddrList", userAddrList);
				
				//무통장 주문 내역
				List<GetBankTransfer> bankTransfers = (List<GetBankTransfer>)map.get("bankTransfer");
				model.addAttribute("bankTransfers", bankTransfers);	
				
				//멤버 프로필 사진
				String memberImg = (String)map.get("memberImg");
				model.addAttribute("memberImg", memberImg);	
				
				//찜목록
				List<SelectWishlist> wishlist = (List<SelectWishlist>)map.get("wishlist");
				model.addAttribute("wishlist", wishlist);	
				
				//포인트로그
				List<PointLog> pl = (List<PointLog>)map.get("pointLog");
				model.addAttribute("pointLog", pl);
				
				//적립금 로그
				List<RewardLog> rl = (List<RewardLog>)map.get("rewardLog");
				model.addAttribute("rewardLog", rl);
				
				//쿠폰로그
				List<MyPageCouponLog> cl = (List<MyPageCouponLog>)map.get("couponLog");
				model.addAttribute("couponLog", cl);
				
				//작성한 리뷰
				List<MyPageReview> reviewList = (List<MyPageReview>)map.get("myReview");
				model.addAttribute("reviewList", reviewList);
				
			} catch (SQLException | NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping(value = "myPage", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> myPagePost(Model model, @RequestParam(value = "pageNo", defaultValue = "1")int pageNo,
			HttpServletRequest request) {
	
		System.out.println("@@@@@@@@@@@@마이페이지 포스트" + pageNo);

		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		

		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");

		ResponseEntity<Map<String, Object>> result = null;
		try {
			// 주문내역
			Map<String, Object> map = mService.memberInfo(memberId, pageNo);

			List<MyPageOrderList> lst = (List<MyPageOrderList>) map.get("orderHistory");
			PagingInfo pi = (PagingInfo) map.get("pagenation");

			model.addAttribute("orderList", lst);
			model.addAttribute("page", pi);

			result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);

		} catch (SQLException | NamingException e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "myPage/modifyShippingAddr", method = RequestMethod.POST)
	public ResponseEntity<ShippingAddress> modifyShippingAddr(@RequestParam Map<String, Object> map,
			HttpServletRequest request) {
		System.out.println("배송지 수정");
		ResponseEntity<ShippingAddress> result = null;
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		if(member != null) {
			String memberId = member.getMemberId();
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", "application/json; charset=UTF-8");
			
			
			
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
			} else {
				// addrSeqObj가 null인 경우
				System.out.println("addrSeq null");
			}
			
		}


		return result;
	}

	@RequestMapping(value = "shippingAddrModify", method = RequestMethod.POST)
	public ResponseEntity<ShippingAddress> shippingAddrModify(@ModelAttribute ShippingAddress tmpAddr,
			HttpServletRequest request, @RequestParam Map<String, Object> map) {
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
		} else {
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
	public ResponseEntity<String> withdrawMember(HttpServletRequest request,
			@RequestParam("password") String password) {

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
					System.out.println("배송주소록 삭제 완");
					;
				}
			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
			}
		} else {
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

				if (mService.setBasicAddr(memberId, addrSeq)) {
					System.out.println(addrSeq + "번 배송지가 기본배송지로 바뀌었습니다.");
					result = new ResponseEntity<String>("success", HttpStatus.OK);
				}

			} catch (Exception e) {
				System.out.println("예외났음 : " + addrSeqObj);
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} else {
			// addrSeqObj가 null인 경우
			System.out.println("addrSeq null");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}

	@RequestMapping("orderDetail")
	public void orderDetail(@RequestParam("no") String orderNo, HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		Map<String, Object> result = null;

		try {
			// 주문상품 상세정보
			List<DetailOrder> detailOrder = mService.getDetailOrderInfo(memberId, orderNo);
			model.addAttribute("detailOrderInfo", detailOrder);
			System.out.println("주문상품상세정보!!!!!" + detailOrder.toString());

			Map<String, Object> map = mService.getOrderInfo(memberId, orderNo);
			// 주문상세정보
			DetailOrderInfo detailOrderInfo = (DetailOrderInfo) map.get("detailOrderInfo");
			// 쿠폰사용내역
			List<CouponHistory> couponHistory = (List<CouponHistory>) map.get("couponsHistory");
			// 무통장 결제내역
			GetBankTransfer bankTransfer = (GetBankTransfer) map.get("bankTransfer");
			
			//총 주문 수량
			int orderQty = (int)map.get("orderQty");			
			
			// 회원정보
			Member userInfo = mService.getMyInfo(memberId);
			
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("detailOrder", detailOrderInfo);
			model.addAttribute("couponHistory", couponHistory);
			model.addAttribute("bankTransfer", bankTransfer);
			model.addAttribute("orderQty", orderQty);

			// 배송주소록
			List<ShippingAddress> userAddrList = mService.getShippingAddress(memberId);
			model.addAttribute("userAddrList", userAddrList);

		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "orderDetailWithJson", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> orderDetailFromJson(@RequestParam("orderNo") String orderNo, @RequestParam("detailedOrderId") int detailedOrderId,
			 HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			// 주문상품 상세정보, 쿠폰사용내역
			Map<String, Object> map = mService.selectCancelOrder(memberId, orderNo, detailedOrderId);


			result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@RequestMapping(value = "orderDetail", method = RequestMethod.POST)
	public void orderDetailPost() {
		System.out.println("상세페이지");
	}

	@RequestMapping(value = "editDeliveryAddress", method = RequestMethod.POST)
	public ResponseEntity<String> editDeliveryAddress(@ModelAttribute DetailOrderInfo updateDetailOrderAddr,
			HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		ResponseEntity<String> result = null;

		try {
			if (mService.updateDetailOrderAddr(updateDetailOrderAddr, memberId)) {
				System.out.println("배송지 변경 완");
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "selectBasicAddr", method = RequestMethod.POST)
	public ResponseEntity<String> getBasicAddrList(HttpServletRequest request, @RequestParam("addrSeq") int addrSeq,
			@RequestParam("deliveryMessage") String deliveryMessage, @RequestParam("orderNo") String orderNo) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();

		ResponseEntity<String> result = null;

		try {
			if (mService.selectBasicAddr(memberId, addrSeq, orderNo, deliveryMessage)) {
				System.out.println("배송지 변경 완");
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}

	@RequestMapping(value = "searchOrderStatus", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> searchOrderStatus(@ModelAttribute GetOrderStatusSearchKeyword keyword,
		HttpServletRequest request, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, Model model) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@키워드" + keyword.toString());
		ResponseEntity<Map<String, Object>> result = null;

		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");

		try {
			Map<String, Object> map = mService.searchOrderStatus(memberId, keyword, pageNo);
			List<MyPageOrderList> sos = (List<MyPageOrderList>) map.get("orderStatus");
			PagingInfo page = (PagingInfo) map.get("pagination");

			model.addAttribute("page", page);

			if (sos != null) {
				result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);
			} else {
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} catch (SQLException | NamingException e) {
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "cancelOrder", method = RequestMethod.POST)
	public ResponseEntity<String> cancelOrder(@ModelAttribute CancelDTO tmpCancel, HttpServletRequest request) {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@취소 " + tmpCancel.toString());
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<String> result = null;
		
		try {
			 if(mService.cancelOrder(tmpCancel, memberId)) {
				 result = new ResponseEntity<String>("success", HttpStatus.OK);				 
			 }

		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
		}
		return result;
	}
	
	@RequestMapping(value = "returnOrder", method = RequestMethod.POST)
	public ResponseEntity<String> returnOrder(@ModelAttribute ReturnOrder ro, HttpServletRequest request) {
		System.out.println("반품버튼 눌렀다." + ro.toString());
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<String> result = null;
		
		try {
			if(mService.returnOrder(ro, memberId)){
				 result = new ResponseEntity<String>("success", HttpStatus.OK);	
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
		}
		
		return result;
	}
	
	@RequestMapping(value = "applyExchange", method = RequestMethod.POST)
	public ResponseEntity<String> applyExchange(@ModelAttribute exchangeDTO ed, HttpServletRequest request){
			System.out.println("교환합니당" + ed.toString());
			
			HttpSession session = request.getSession();
			Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
			String memberId = member.getMemberId();
			
			ResponseEntity<String> result = null;
			
			try {
				if(mService.exchangeOrder(ed, memberId)) {
					result = new ResponseEntity<String>("success", HttpStatus.OK);	
				}
			} catch (SQLException | NamingException e) {
				result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
				e.printStackTrace();
			}
			
		return result;
	}
	
	@PostMapping("profileUpload")
	public ResponseEntity<UploadFiles> rofileUpload(MultipartFile uploadFile, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		System.out.println(member.toString());
		
		System.out.println("프로필 업로드 시작");
		System.out.println("파일의 오리지널 이름 : " + uploadFile.getOriginalFilename());
		System.out.println("파일의 사이즈 : " + uploadFile.getSize());
		System.out.println("파일의 contentType : " + uploadFile.getContentType());
		
		String realPath = request.getSession().getServletContext().getRealPath("resources/assets/images/profile");
		
		System.out.println(realPath);
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		ResponseEntity<UploadFiles> result = null;
		
		UploadFiles uf = null;
		try {
			uf = UploadProfileFileProcess.fileUpload(uploadFile.getOriginalFilename(),  uploadFile.getSize(), uploadFile.getContentType(),
						 uploadFile.getBytes(), realPath, memberId);
			System.out.println(uf.toString());
			if(mService.insertUploadProfile(uf, memberId)) {
				result = new ResponseEntity<UploadFiles>(uf, header, HttpStatus.OK);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "modifyReview", method = RequestMethod.POST)
	public @ResponseBody List<UploadFiles> modifyReview(MultipartFile uploadFile, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		System.out.println("파일의 오리지널 이름 : " + uploadFile.getOriginalFilename());
		System.out.println("파일의 사이즈 : " + uploadFile.getSize());
		System.out.println("파일의 contentType : " + uploadFile.getContentType()); //mime-type 이다. server에 web.xml에 정의되어있다. 실제 어떤 형식의 파일인지 컴퓨터끼리 아는것.
		//파일이 저장될 물리적 경로(realPath)
		String realPath = request.getSession().getServletContext().getRealPath("resources/assets/images/review"); //java파일이랑 webapp 까지는 경로가 같아서 경로를 이렇게 지정한다.
		System.out.println(realPath);
	
		UploadFiles uf = null;
		
		try {
			uf = UploadProfileFileProcess.fileUpload(uploadFile.getOriginalFilename(),  uploadFile.getSize(), uploadFile.getContentType(),
					 uploadFile.getBytes(), realPath, memberId);
			System.out.println(uf.toString());
			if(uf != null) {
				this.fileList.add(uf);
				
			}
		} catch (IOException e) {
			e.printStackTrace();
			uf = null; 
		}
		
		for(UploadFiles f : this.fileList) {
			System.out.println("현재 파일 업로드 리스트 : " + f.toString());
		}
		return this.fileList;
	}
	
	@RequestMapping("remFile")
	public ResponseEntity<String> removeFile(@RequestParam("removeFile") String remFile, HttpServletRequest request) {
		System.out.println(remFile + "파일을 삭제하자");
		
		//this.fileList[remInd] 번째의 파일을 하드디스크에서 먼저 삭제 한 뒤
		//this.fileList[remInd] 번째 this.fileList에서 삭제
		String realPath = request.getSession().getServletContext().getRealPath("resources/assets/images/review");
		
		ResponseEntity<String> result = null;
		
		UploadProfileFileProcess.deleteFile(this.fileList, remFile, realPath);
			
		int ind = 0;
		for(UploadFiles uf : fileList) {
			if(!remFile.equals(uf.getOriginalFileName())) {
				ind++;
			}else if(remFile.equals(uf.getOriginalFileName())){
				break;
			}
		}
		this.fileList.remove(ind);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		for(UploadFiles f : this.fileList) {
			System.out.println("현재 파일 업로드 리스트 : " + f.toString());
		}
		return result;
	}
	
	@RequestMapping("remAllFile")
	public ResponseEntity<String> remAllFile(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/assets/images/review");
		UploadProfileFileProcess.deleteAllFile(this.fileList, realPath);
		
		this.fileList.clear();
		
		return new ResponseEntity<String>("success", HttpStatus.ACCEPTED);
	}
	
	@RequestMapping(value = "delWishlist", method = RequestMethod.POST)
	public ResponseEntity<String> delWishlist(@RequestParam("productId") String productId, HttpServletRequest request) {
		System.out.println(productId + "번 상품 삭제");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<String> result = null;
		
		try {
			if(lService.deleteWishList(memberId, productId)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "addShoppingCart", method = RequestMethod.POST)
	public ResponseEntity<String> addShoppingCart(@RequestParam("productId") String productId, HttpServletRequest request) {
		System.out.println(productId + "번 상품 장바구니 추가");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<String> result = null;
		
		try {
			if(mService.addShoppingCart(memberId, productId)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "selectModifyReview", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> selectModifyReview(@RequestParam("postNo") int postNo, HttpServletRequest request){
		System.out.println(postNo + "번 리뷰수정");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<Map<String, Object>> result = null;
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		try {
			Map<String, Object> map = mService.selectMyReview(memberId, postNo);
			
			result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	
	

}
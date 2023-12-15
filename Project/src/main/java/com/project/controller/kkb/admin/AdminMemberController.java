package com.project.controller.kkb.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminBoardService;
import com.project.service.kkb.admin.AdminCouponService;
import com.project.service.kkb.admin.AdminInquiryService;
import com.project.service.kkb.admin.AdminMemberService;
import com.project.service.kkb.admin.AdminMemoService;
import com.project.service.kkb.admin.AdminOrderService;
import com.project.service.kkb.admin.AdminPointService;
import com.project.service.kkb.admin.AdminRewardService;
import com.project.service.kkb.admin.AdminShoppingCartService;
import com.project.vodto.kkb.InquiryCondition;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoInfoCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.PostCondition;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/members")
public class AdminMemberController {
	
	private final AdminMemberService adminMemberService;
	private final AdminOrderService adminOrderService;
	private final AdminBoardService adminBoardService;
	private final AdminInquiryService adminInquiryService;
	private final AdminRewardService adminRewardService;
	private final AdminPointService adminPointService;
	private final AdminCouponService adminCouponService;
	private final AdminShoppingCartService adminShoppingCartService;
	private final AdminMemoService adminMemoService;
	
	/* 회원 수 변경 시 이벤트 발행(test) */
	@GetMapping("/test")
	public void eventTest() {
		adminMemberService.updateMemberCount();
	}
	
	/* 총 회원 수 */
	@GetMapping("/count")
	public Map<String, Object> countTotalMember() {
		return adminMemberService.getTotalMemberCount();
	}
	
	/* 회원 정보 조회 */
	@PostMapping("/search")
	public Map<String, Object> searchMemberInfo(@RequestBody MemberCondition memberCond) {		
		return adminMemberService.getMemberInfo(memberCond);
	}
	
	/* CRM 홈 */
	@GetMapping("/{memberId}")
	public Map<String, Object> checkMemberDetailHome(@PathVariable("memberId") String memberId) {
		return adminMemberService.getHomeDetailInfo(memberId);
	}
	
	/* CRM 회원 상세정보 */
	@GetMapping("/{memberId}/detail")
	public Map<String, Object> checkMemberDetail(@PathVariable("memberId") String memberId) {
		return adminMemberService.getMemberDetailInfo(memberId);
	}
	
	/* CRM 회원 상세정보 수정 */
	@PutMapping("/{memberId}/update")
	public ResponseEntity<String> setMemberDetail(@RequestBody MemberParam member) {
		int result = adminMemberService.editMemberDetailInfo(member);
		
		if (result > 0) {
	        return new ResponseEntity<>("Member information updated successfully", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("Failed to update member information", HttpStatus.NOT_FOUND);
	    }
	}
	
	/* CRM 전체 주문 조회 */
	@GetMapping("/{memberId}/search")
	public Map<String, Object> searchOrderInfo(
			@RequestParam String orderNo,
			@RequestParam String productOrderNo,
			@RequestParam String invoiceNumber,
			@RequestParam String name,
			@RequestParam String memberId,
			@RequestParam String email,
			@RequestParam String cellPhoneNumber,
			@RequestParam String phoneNumber,
			@RequestParam String payerName,
			@RequestParam String recipientName,
			@RequestParam String recipientPhoneNumber,
			@RequestParam String shippingAddress,
			@RequestParam String productName,
			@RequestParam String productId,
			@RequestParam String categoryKey,
			@RequestParam String orderTimeStart,
			@RequestParam String orderTimeEnd,
			@RequestParam String paymentTimeStart,
			@RequestParam String paymentTimeEnd) {	

		OrderCondition orderCond = OrderCondition.create(
				orderNo,productOrderNo, invoiceNumber, name, memberId, 
				email, cellPhoneNumber, phoneNumber, payerName, recipientName, 
				recipientPhoneNumber, shippingAddress, productName, productId, categoryKey, 
				orderTimeStart, orderTimeEnd, paymentTimeStart, paymentTimeEnd);
		
		return adminOrderService.getOrderInfo(orderCond);
	}
	
	/* CRM 게시물 정보 */  // 수정 대기
	@PostMapping("/{memberId}/board")
	public Map<String, Object> searchPostInfo(@RequestBody PostCondition postCond) {
		return adminBoardService.getPostInfo(postCond);
	}
	
	/* CRM 1:1 문의 정보 */
	@GetMapping("/{memberId}/inquiry")
	public Map<String, Object> searchInquiryInfo(
			@RequestParam  String createdDateStart, 
			@RequestParam  String createdDateEnd, 
			@RequestParam  String title, 
			@RequestParam  String email, 
			@RequestParam  String content,
			@RequestParam  String author, 
			@RequestParam  String name, 
			@RequestParam  String orderNo, 
			@RequestParam  String answerStatus, 
			@RequestParam  String inquiryType, 
			@RequestParam  byte file) {
		
		InquiryCondition inquiryCond = InquiryCondition.create(
				createdDateStart, createdDateEnd, title, email, content, author, name, orderNo, answerStatus, inquiryType, file);
		
		return adminInquiryService.getInquiryInfo(inquiryCond);
	}
	
	/* CRM [적립금]/포인트/쿠폰 */
	@GetMapping("/{memberId}/reward")
	public Map<String, Object> checkRewardInfo(@PathVariable("memberId") String memberId) {
		return adminRewardService.getRewardInfo(memberId);
	}
	
	/* CRM 적립금/[포인트]/쿠폰 */
	@GetMapping("/{memberId}/point")
	public Map<String, Object> checkPointInfo(@PathVariable("memberId") String memberId) {
		return adminPointService.getPointInfo(memberId);
	}
	
	/* CRM 적립금/포인트/[쿠폰] */
	@GetMapping("/{memberId}/coupon")
	public Map<String, Object> checkCouponInfo(@PathVariable("memberId") String memberId) {
		return adminCouponService.getCouponInfo(memberId);
	}
	
	/* CRM 적립금/포인트/[쿠폰]  - 쿠폰 적용 카테고리 */
	@GetMapping("/{memberId}/category/{couponNumber}")
	public Map<String, Object> checkAppliedCategory(@PathVariable("couponNumber") String couponNumber) {
		return adminCouponService.getCategoryByCouponNo(couponNumber);
	}
	
	/* CRM 장바구니 정보 */
	@GetMapping("/{memberId}/cart")
	public Map<String, Object> checkCartInfo(@PathVariable("memberId") String memberId) {
		return adminShoppingCartService.getCartInfoById(memberId);
	}
	
	/* CRM 회원 메모 검색 */
	@GetMapping("/{memberId}/memo")
	public Map<String, Object> searchMemoInfo(
			@RequestParam  String createdDateStart, 
			@RequestParam  String createdDateEnd, 
			@RequestParam  String memberId, 
			@RequestParam  byte important, 
			@RequestParam  String content) {
		
		MemoInfoCondition memoInfoCond = MemoInfoCondition.create(
				createdDateStart, createdDateEnd, memberId, important, content);
		
		return adminMemoService.getMemoById(memoInfoCond);
	}
	
	/* CRM 회원 메모 작성 */
	@PostMapping("/{memberId}/memo/write")
	public ResponseEntity<String> addMemberMemo(@RequestBody MemoCondition memoCond, HttpServletRequest req) {
		int result = adminMemoService.addMemberMemo(memoCond, req);
		
		if (result > 0) {
	        return new ResponseEntity<>("Member memo add successful", HttpStatus.CREATED);
	    } else {
	        return new ResponseEntity<>("Failed to add member memo", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	/* CRM 회원 메모 삭제 */
}

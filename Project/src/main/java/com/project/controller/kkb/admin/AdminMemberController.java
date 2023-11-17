package com.project.controller.kkb.admin;

import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminBoardService;
import com.project.service.kkb.admin.AdminCouponService;
import com.project.service.kkb.admin.AdminInquiryService;
import com.project.service.kkb.admin.AdminMemberService;
import com.project.service.kkb.admin.AdminOrderService;
import com.project.service.kkb.admin.AdminPointService;
import com.project.service.kkb.admin.AdminRewardService;
import com.project.vodto.kkb.InquiryCondition;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
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
	
	/* 회원 수 변경 시 이벤트 발행(test) */
	@GetMapping("/test")
	public void eventTest() throws Exception {
		adminMemberService.updateMemberCount();
	}
	
	/* 총 회원 수 */
	@GetMapping("/count")
	public Map<String, Object> countTotalMember() throws Exception {
		return adminMemberService.getTotalMemberCount();
	}
	
	/* 회원 정보 조회 */
	@PostMapping("/search")
	public Map<String, Object> searchMemberInfo(@RequestBody MemberCondition memberCond) throws Exception {		
		return adminMemberService.getMemberInfo(memberCond);
	}
	
	/* CRM 홈 */
	@GetMapping("/{memberId}")
	public Map<String, Object> checkMemberDetailHome(@PathVariable("memberId") String memberId) throws Exception {
		return adminMemberService.getHomeDetailInfo(memberId);
	}
	
	/* CRM 회원 상세정보 */
	@GetMapping("/detail/{memberId}")
	public Map<String, Object> checkMemberDetail(@PathVariable("memberId") String memberId) throws Exception {
		return adminMemberService.getMemberDetailInfo(memberId);
	}
	
	/* CRM 회원 상세정보 수정 */
	@PutMapping("/detail/update")
	public Map<String, Object> modifyMemberDetail(@RequestBody MemberParam member) throws Exception {
		return adminMemberService.editMemberDetailInfo(member);
	}
	
	/* CRM 전체 주문 조회 */
	@PostMapping("/detail/search")
	public Map<String, Object> searchOrderInfo(@RequestBody OrderCondition orderCond) throws Exception {	
		return adminOrderService.getOrderInfo(orderCond);
	}
	
	/* CRM 게시물 정보 */
	@PostMapping("/detail/board")
	public Map<String, Object> searchPostInfo(@RequestBody PostCondition postCond) throws Exception {
		return adminBoardService.getPostInfo(postCond);
	}
	
	/* CRM 1:1 문의 정보 */
	@PostMapping("/detail/inquiry")
	public Map<String, Object> searchInquiryInfo(@RequestBody InquiryCondition inquiryCond) throws Exception {
		return adminInquiryService.getInquiryInfo(inquiryCond);
	}
	
	/* CRM [적립금]/포인트/쿠폰 */
	@GetMapping("/detail/reward/{memberId}")
	public Map<String, Object> checkRewardInfo(@PathVariable("memberId") String memberId) throws Exception {
		return adminRewardService.getRewardInfo(memberId);
	}
	
	/* CRM 적립금/[포인트]/쿠폰 */
	@GetMapping("/detail/point/{memberId}")
	public Map<String, Object> checkPointInfo(@PathVariable("memberId") String memberId) throws Exception {
		return adminPointService.getPointInfo(memberId);
	}
	
	/* CRM 적립금/포인트/[쿠폰] */
	@GetMapping("/detail/coupon/{memberId}")
	public Map<String, Object> checkCouponInfo(@PathVariable("memberId") String memberId) throws Exception {
		return adminCouponService.getCouponInfo(memberId);
	}
	
	/* CRM 적립금/포인트/[쿠폰]  - 쿠폰 적용 카테고리*/
	@GetMapping("/detail/category/{couponNumber}")
	public Map<String, Object> checkAppliedCategory(@PathVariable("couponNumber") String couponNumber) throws Exception {
		return adminCouponService.getCategoryByCouponNo(couponNumber);
	}
}

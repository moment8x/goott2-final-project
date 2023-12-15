package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.CouponAppliedCategory;
import com.project.vodto.kkb.CouponInfoResponse;
import com.project.vodto.kkb.CouponListResponse;

public interface AdminCouponDAO {

	/* 쿠폰 정보 */
	CouponInfoResponse findCouponInfoById(String memberId);
	
	
	/* 쿠폰 현황*/
	List<CouponListResponse> findCouponListById(String memberId);
	
	
	/* 쿠폰 적용 카테고리 */
	CouponAppliedCategory findCategoryByCouponNo(String couponNumber);
	
}

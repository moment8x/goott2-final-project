package com.project.service.kkb.admin;

import java.util.Map;

public interface AdminCouponService {
	
	/* 쿠폰 정보 및 현황 */
	Map<String, Object> getCouponInfo(String memberId);
	
	/* 쿠폰 적용 카테고리 */
	Map<String, Object> getCategoryByCouponNo(String couponNumber);
}

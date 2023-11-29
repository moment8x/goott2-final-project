package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminCouponDAO;
import com.project.vodto.kkb.CouponAppliedCategory;
import com.project.vodto.kkb.CouponInfoResponse;
import com.project.vodto.kkb.CouponListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminCouponServiceImpl implements AdminCouponService {

	private final AdminCouponDAO adminCouponRepository;
	
	@Override
	public Map<String, Object> getCouponInfo(String memberId) {
		
		CouponInfoResponse couponInfo = adminCouponRepository.findCouponInfoById(memberId);
		List<CouponListResponse> couponList = adminCouponRepository.findCouponListById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("couponInfo", couponInfo);
		result.put("couponList", couponList);
		
		return result;
	}

	@Override
	public Map<String, Object> getCategoryByCouponNo(String couponNumber) {
		
		CouponAppliedCategory categories = adminCouponRepository.findCategoryByCouponNo(couponNumber);
		
		Map<String, Object> result = new HashMap<>();
		result.put("categories", categories);
		
		return result;
	}

}

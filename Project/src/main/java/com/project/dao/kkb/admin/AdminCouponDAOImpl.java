package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.CouponAppliedCategory;
import com.project.vodto.kkb.CouponInfoResponse;
import com.project.vodto.kkb.CouponListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminCouponDAOImpl implements AdminCouponDAO {
	
	private static String ns = "com.project.mappers.adminCouponMapper";
	private final SqlSession ses;
	
	@Override
	public CouponInfoResponse findCouponInfoById(String memberId) {
		return ses.selectOne(ns + ".selectCouponInfo", memberId);
	}

	@Override
	public List<CouponListResponse> findCouponListById(String memberId) {
		return ses.selectList(ns +".selectCouponList", memberId);
	}

	@Override
	public CouponAppliedCategory findCategoryByCouponNo(String couponNumber) {
		return ses.selectOne(ns + ".selectAppliedCategory", couponNumber);
	}

}

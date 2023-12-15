package com.project.vodto.kkb;

import java.util.List;
import java.util.stream.Collectors;

import lombok.Getter;

@Getter
public class CanceledCoupons {
	private String orderNo;
	private int couponCount;
	
	private CanceledCoupons(String orderNo, int couponCount) {
		this.orderNo = orderNo;
		this.couponCount = couponCount;
	}
	
	public static List<CanceledCoupons> convert(List<CheckedCoupons> couponList) {
		
		return couponList.stream()
                .map(checkedCoupons -> {
                    int canceledCouponCount = Math.toIntExact(checkedCoupons.getCoupons().stream()
                            .filter(couponCount -> couponCount.getCount() == 0)
                            .count());

                    CanceledCoupons canceledCoupons = new CanceledCoupons(
                    		checkedCoupons.getOrderNo(),
                    		canceledCouponCount);

                    return canceledCoupons;
                })
                .collect(Collectors.toList());		
	}
	
	
}

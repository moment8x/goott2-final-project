package com.project.vodto.kkb;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckedCoupons {
	private String orderNo;
	private List<CouponCount> coupons;
}

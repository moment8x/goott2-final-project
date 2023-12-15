package com.project.vodto.kkb;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CouponAppliedCategory {
	private String couponNumber;
	private String couponName;
	private List<AppliedCategory> categories; 
}

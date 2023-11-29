package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Coupon {
	private String couponNumber;
	private int discountAmount;
	private int termOfValidity;
	private String couponName;
}
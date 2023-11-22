package com.project.vodto.jmj;

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
public class CouponHistory {
	//coupons
	private char discountMethod; //할인방법
	private int discountAmount; // 할인금액(%)
	private int termOfValidity; // 사용기한
	private String couponName;
	
	//coupon_log
	private Timestamp obtainedDate; //얻은 날짜
	private Timestamp usedDate;
	private Timestamp expirationDate; //만료일
	private int couponLogsSeq;
	
	//coupon_categories
	private String categoryKey; //적용가능한 상품 카테고리 키
}

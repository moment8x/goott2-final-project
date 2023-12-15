package com.project.vodto;

import java.sql.Timestamp;
import java.util.List;

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
public class CouponInfos {
	private String memberId;
	private String couponNumber;
	private Timestamp obtainedDate;
	private Timestamp usedDate;
	private Timestamp expirationDate;
	private String couponName;
	private char discountMethod;
	private int discountAmount;
	private List<String> categoryKey;
//	private String categoryKey; // 따로 받자?
}

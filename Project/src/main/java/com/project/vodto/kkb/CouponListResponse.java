package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CouponListResponse {
	private String couponNumber;
	private String couponName;
	private String categoryName;
	private int discountAmount;
	private Timestamp obtainedDate;
	private Timestamp expirationDate;
	private Timestamp usedDate;
	private String relatedOrder;
}

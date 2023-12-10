package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RevenueResponse {
	private String date;
	private String orderCount;
	private String itemCount;
	private String totalPurchaseAmount;
	private String shippingFee;
	private String coupon;
	private String reward;
	private String point;
	private String totalPaymentAmount;
	private String totalRefundAmount;
	private String netSales;
}

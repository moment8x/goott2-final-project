package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RevenueResponse {
	private String date;
	private int orderCount;
	private int itemCount;
	private int totalPurchaseAmount;
	private int shippingFee;
	private int coupon;
	private int reward;
	private int point;
	private int totalPaymentAmount;
	private int totalRefundAmount;
	private int netSales;
}

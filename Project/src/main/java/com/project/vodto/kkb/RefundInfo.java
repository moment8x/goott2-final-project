package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RefundInfo {
	private String productOrderNo;
	private String orderNo;
	private int totalAmount; 
	private int actualPaymentAmount; 
	private int usedPoints; 
	private int usedReward; 
	private int couponDiscount;
	private int cancelId;
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RefundNoInfo {
	private String productOrderNo;
	private String orderNo;
	private int totalAmount; 
	private int actualPaymentAmount; 
	private int usedPoints; 
	private int usedReward; 
	private int couponDiscount;
	private String cancelId;
}

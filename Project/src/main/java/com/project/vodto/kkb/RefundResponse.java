package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RefundResponse {
	private Timestamp orderTime;
	private Timestamp refundApplicationDate;
	private Timestamp refundProcessingCompletionDate;
	private String productOrderNo;
	private String orderNo;
	private String refundsId;
	private String name;
	private String memberId;
	private int productQuantity;
	private int totalRefundAmount; 
	private int actualRefundAmount;  
	private int refundRewardUsed;  
	private int refundPointUsed;  
	private String paymentMethod;
	private String refundProcessingDetail;
	private String deliveryMessage;
}

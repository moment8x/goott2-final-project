package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberRecentOrder {

	private Timestamp orderTime;
	private String orderNo;
	private int actualPaymentAmount;
	private String paymentMethod;
	private String paymentStatus;
	private String deliveryStatus;
	private String cancels;
	private String exchanges;
	private String returns;
}

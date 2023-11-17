package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderNoResponse {
	private Timestamp orderTime;
	private Timestamp paymentTime;
	private String orderNo;
	private String name;
	private String memberId;
	private String productName;
	private int totalAmount;
	private int actualPaymentAmount;
	private String paymentMethod;
	private String paymentStatus;
	private int undelivered;
	private int inTransit;
	private int delivered;
	private int cancels;
	private int exchanges;
	private int returns;
	private String deliveryMessage;
}

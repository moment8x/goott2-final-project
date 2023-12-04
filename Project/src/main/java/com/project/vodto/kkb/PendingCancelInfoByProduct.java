package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;

@Getter
public class PendingCancelInfoByProduct {
	private Timestamp orderTime;
	private Timestamp requestTime;
	private String orderNo;
	private String name;
	private String memberId;
	private int amountToPay;
	private String paymentMethod;
	private String deliveryMessage;
	private List<PendingCancelInfoProduct> orders;
	
	public PendingCancelInfoByProduct(Timestamp orderTime, Timestamp requestTime, String orderNo, String name,
			String memberId, int amountToPay, String paymentMethod, String deliveryMessage,
			List<PendingCancelInfoProduct> orders) {
		this.orderTime = orderTime;
		this.requestTime = requestTime;
		this.orderNo = orderNo;
		this.name = name;
		this.memberId = memberId;
		this.amountToPay = amountToPay;
		this.paymentMethod = paymentMethod;
		this.deliveryMessage = deliveryMessage;
		this.orders = orders;
	}
	
	
}

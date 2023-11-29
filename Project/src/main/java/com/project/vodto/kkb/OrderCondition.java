package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;

@Getter
public class OrderCondition {
	private String orderNo;
	private String productOrderNo;
	private String invoiceNumber;
	private String name;
	private String memberId;
	private String email;
	private String cellPhoneNumber;
	private String phoneNumber;
	private String payerName;
	private String recipientName;
	private String recipientPhoneNumber;
	private String shippingAddress;
	private String productName;
	private String productId;
	private String categoryKey;
	private Date orderTimeStart;
	private Date orderTimeEnd;
	private Date paymentTimeStart;
	private Date paymentTimeEnd;
	
	private OrderCondition(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, Date orderTimeStart, Date orderTimeEnd, Date paymentTimeStart, Date paymentTimeEnd) {
		this.orderNo = orderNo;
		this.productOrderNo = productOrderNo;
		this.invoiceNumber = invoiceNumber;
		this.name = name;
		this.memberId = memberId;
		this.email = email;
		this.cellPhoneNumber = cellPhoneNumber;
		this.phoneNumber = phoneNumber;
		this.payerName = payerName;
		this.recipientName = recipientName;
		this.recipientPhoneNumber = recipientPhoneNumber;
		this.shippingAddress = shippingAddress;
		this.productName = productName;
		this.productId = productId;
		this.categoryKey = categoryKey;
		this.orderTimeStart = orderTimeStart;
		this.orderTimeEnd = orderTimeEnd;
		this.paymentTimeStart = paymentTimeStart;
		this.paymentTimeEnd = paymentTimeEnd;
	}
	
	public static OrderCondition create(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, String orderTimeStart, String orderTimeEnd, String paymentTimeStart, String paymentTimeEnd) {
		
		orderTimeStart = orderTimeStart.equals("") ? "0000-01-01" : orderTimeStart;
		orderTimeEnd = orderTimeEnd.equals("") ? "9999-12-31" : orderTimeEnd;
		paymentTimeStart = paymentTimeStart.equals("") ? "0000-01-01" : paymentTimeStart;
		paymentTimeEnd = paymentTimeEnd.equals("") ? "9999-12-31" : paymentTimeEnd;
		
		return new OrderCondition(
				orderNo, 
				productOrderNo, 
				invoiceNumber, 
				name, 
				memberId,
				email, 
				cellPhoneNumber, 
				phoneNumber, 
				payerName, 
				recipientName,
				recipientPhoneNumber, 
				shippingAddress, 
				productName, 
				productId,
				categoryKey, 
				Date.valueOf(orderTimeStart), 
				Date.valueOf(orderTimeEnd), 
				Date.valueOf(paymentTimeStart), 
				Date.valueOf(paymentTimeEnd));
	}
}

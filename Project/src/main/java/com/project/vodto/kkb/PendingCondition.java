package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;

@Getter
public class PendingCondition {
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
	private Date confirmDateStart;
	private Date confirmDateEnd;
	
	private PendingCondition(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, Date orderTimeStart, Date orderTimeEnd, Date confirmDateStart, Date confirmDateEnd) {
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
		this.confirmDateStart = confirmDateStart;
		this.confirmDateEnd = confirmDateEnd;
	}
	
	public static PendingCondition create(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, String orderTimeStart, String orderTimeEnd, String confirmDateStart, String confirmDateEnd) {
		
		orderTimeStart = orderTimeStart.equals("") ? "0000-01-01" : orderTimeStart;
		orderTimeEnd = orderTimeEnd.equals("") ? "9999-12-31" : orderTimeEnd;
		confirmDateStart = confirmDateStart.equals("") ? "0000-01-01" : confirmDateStart;
		confirmDateEnd = confirmDateEnd.equals("") ? "9999-12-31" : confirmDateEnd;
		
		return new PendingCondition(
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
				Date.valueOf(confirmDateStart), 
				Date.valueOf(confirmDateEnd));
	}
}

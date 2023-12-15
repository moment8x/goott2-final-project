package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;

@Getter
public class CancelCondition {
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
	private Date requestTimeStart;
	private Date requestTimeEnd;
	private Date completionTimeStart;
	private Date completionTimeEnd;
	
	public CancelCondition(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, Date orderTimeStart, Date orderTimeEnd, Date requestTimeStart, Date requestTimeEnd,
			Date completionTimeStart, Date completionTimeEnd) {
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
		this.requestTimeStart = requestTimeStart;
		this.requestTimeEnd = requestTimeEnd;
		this.completionTimeStart = completionTimeStart;
		this.completionTimeEnd = completionTimeEnd;
	}
	
	public static CancelCondition create(String orderNo, String productOrderNo, String invoiceNumber, String name, String memberId,
			String email, String cellPhoneNumber, String phoneNumber, String payerName, String recipientName,
			String recipientPhoneNumber, String shippingAddress, String productName, String productId,
			String categoryKey, String orderTimeStart, String orderTimeEnd, String requestTimeStart, 
			String requestTimeEnd, String completionTimeStart, String completionTimeEnd) {
		
		orderTimeStart = orderTimeStart.equals("") ? "0000-01-01" : orderTimeStart;
		orderTimeEnd = orderTimeEnd.equals("") ? "9999-12-31" : orderTimeEnd;
		requestTimeStart = requestTimeStart.equals("") ? "0000-01-01" : requestTimeStart;
		requestTimeEnd = requestTimeEnd.equals("") ? "9999-12-31" : requestTimeEnd;
		completionTimeStart = completionTimeStart.equals("") ? "0000-01-01" : completionTimeStart;
		completionTimeEnd = completionTimeEnd.equals("") ? "9999-12-31" : completionTimeEnd;
		
		return new CancelCondition(
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
				Date.valueOf(requestTimeStart), 
				Date.valueOf(requestTimeEnd),
				Date.valueOf(completionTimeStart), 
				Date.valueOf(completionTimeEnd));
	}

}

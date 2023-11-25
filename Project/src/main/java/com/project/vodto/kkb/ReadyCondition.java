package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReadyCondition {
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
}

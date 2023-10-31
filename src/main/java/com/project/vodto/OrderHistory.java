package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class OrderHistory {
	private String orderNo;
	private String memberId;
	private String invoiceNumber;
	private String recipientName;
	private String recipientPhoneNumber;
	private Timestamp orderTime;
	private String zipCode;
	private String shippingAddress;
	private String detailedShippingAddress;
	private String deliveryStatus;
	private String deliveryMessage;
}
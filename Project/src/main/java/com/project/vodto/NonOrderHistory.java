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
public class NonOrderHistory {
	private int nonOrderNo;
	private String nonMemberId;
	private String invoiceNumber;
	private String recipientName;
	private String recipientPhoneNumber;
	private Timestamp orderTime;
	private String zipcode;
	private String shippingAddress;
	private String detailShippingAddress;
	private String deliveryStatus;
	private String deliveryMessage;
	private Timestamp nonDeleteDate;
	private String nonPassword;
	private String nonEmail;
}
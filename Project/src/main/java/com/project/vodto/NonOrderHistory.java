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
	private String nonOrderNo;
	private String nonMemberId;
	private String nonInvoiceNumber;
	private String nonRecipientName;
	private String nonRecipientPhoneNumber;
	private Timestamp nonOrderTime;
	private String nonZipCode;
	private String nonShippingAddress;
	private String nonDetailedShippingAddress;
	private String nonDeliveryStatus;
	private String nonDeliveryMessage;
	private Timestamp nonRegisterDate;
	private String nonPassword;
	private String nonEmail;
}
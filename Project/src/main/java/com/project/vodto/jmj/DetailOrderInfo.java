package com.project.vodto.jmj;

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
public class DetailOrderInfo {
	//payments
	private String paymentMethod;
	private int totalAmount;
	private int shippingFee;
	private int usedReward;
	private int usedPoints;
	private int actualPaymentAmount;
	private String cardName;
	private String cardNumber;
	private String paymentStatus;
	private Timestamp paymentTime;
	
	//order_history
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

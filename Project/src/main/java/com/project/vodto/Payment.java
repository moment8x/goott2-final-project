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
public class Payment {
	private String paymentNumber;
	private String orderNo;
	private String nonOrderNo;
	private String paymentMethod;
	private int totalAmount;
	private int shippingFee;
	private int usedReward;
	private int usedPoints;
	private int actualPaymentAmount;
	private Timestamp paymentTime;
	private String cardName;
	private String cardNumber;
	private String paymentStatus; // 11-05 추가
}
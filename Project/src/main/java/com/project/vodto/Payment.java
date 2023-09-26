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
	private int orderNo;
	private int nonOrderNo;
	private String paymentMethod;
	private String totalAmount;
	private int shippingFee;
	private int usedReward;
	private int usedPoints;
	private String actualPaymentAmount;
	private Timestamp paymentTime;
}
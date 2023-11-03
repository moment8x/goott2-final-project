package com.project.vodto.jmj;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class DetailOrder {
	private String orderNo;
	private String invoiceNumber;
	private String recipientName;
	private String recipientPhoneNumber;
	private Timestamp orderTime;
	private String zipCode;
	private String shippingAddress;
	private String detailedShippingAddress;
	private String deliveryStatus;
	private String deliveryMessage;
	private int productPrice;
	private int productQuantity;
	private String productStatus;
	private String paymentMethod;
	private int totalAmount;
	private int shippingFee;
	private int usedReward;
	private int usedPoints;
	private Timestamp paymentTime;
	private String cardName;
	private String cardNumber;
	private String productName;
	private String productInfoImage;
	
}

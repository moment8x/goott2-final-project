package com.project.vodto.ksh;

import java.util.List;

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
public class CompleteOrder {
	private String orderNo;
	private String nonOrderNo;
	private String paymentMethod;
	private String cardName;
	private List<String> productId;
	private int totalAmount;
	private int shippingFee;
	private int actualPaymentAmount;
	private int amountToPay;
	private int discountAmount;
	private String recipientName;
	private String recipientPhoneNumber;
	private String shippingAddress;
	private String detailedShippingAddress;
	private String nonRecipientName;
	private String nonRecipientPhoneNumber;
	private String nonShippingAddress;
	private String nonDetailedShippingAddress;
	
}

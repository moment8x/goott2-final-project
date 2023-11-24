package com.project.vodto.ksh;

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
public class OrderInfo {
	private String productId;
	private String productName;
	private String productImage;
	private int productQuantity;
	private int sellingPrice;
	private int totalAmount;
	private int actualPaymentAmount;
	private int discountAmount; // 수동으로 넣어줘야함
	private String resipientName;
	private String recipientPhoneNumber;
	private String shippingAddress;
	private String detailedShippingAddress;
	private String cardName;
	private String paymentMethod;
	private int couponDiscount;
	private int calculatedPrice;
	private int currentQuantity;
	private String categoryKey;
	private String adequacy;
	
}

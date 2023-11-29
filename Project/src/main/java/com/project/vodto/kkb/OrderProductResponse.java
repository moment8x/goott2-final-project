package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderProductResponse {
	private Timestamp orderTime;
	private Timestamp paymentTime;
	private String orderNo;
	private String productOrderNo;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	private int actualPaymentAmount;
	private String paymentMethod;
	private String paymentStatus;
	private String productStatus;
	private String productInvoiceNumber;
	private String deliveryMessage;
}

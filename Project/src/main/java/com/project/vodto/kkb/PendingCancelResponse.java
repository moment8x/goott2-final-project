package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PendingCancelResponse {
	private Timestamp orderTime;
	private Timestamp requestTime;
	private String productOrderNo;
	private String orderNo;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	private int amountToPay;
	private String paymentMethod;
	private String reason;
	private String deliveryMessage;
}

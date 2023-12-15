package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CancelResponse {
	private Timestamp requestTime;
	private String productOrderNo;
	private String orderNo;
	private String cancelId;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private int amount;
	private String paymentMethod;
	private String reason;
	private String processingStatus;
	private String deliveryMessage;
}

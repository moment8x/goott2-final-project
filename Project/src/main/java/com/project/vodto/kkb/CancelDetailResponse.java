package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CancelDetailResponse {
	private String orderNo;
	private Timestamp orderTime;
	private String cancelId;
	private String productName;
	private String productId;
	private int productQuantity;
	private int sellingPrice;
	private String paymentMethod;
	private String reason;
	private String processingStatus;
	private String deliveryMessage;
}

package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReturnResponse {
	private Timestamp requestTime;
	private String productOrderNo;
	private String orderNo;
	private String returnsId;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private String productInvoiceNumber;
	private String processingStatus;
	private String deliveryMessage;
}

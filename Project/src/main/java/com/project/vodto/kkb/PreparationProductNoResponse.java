package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PreparationProductNoResponse {
	private Timestamp orderTime;
	private Timestamp paymentTime;
	private String name;
	private String memberId;
	private String productOrderNo;
	private String productInvoiceNumber;
	private String productName;
	private String productId;
	private int productQuantity;
	private String deliveryMessage;
}

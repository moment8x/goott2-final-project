package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeliveredProductNoResponse {
	private Timestamp orderTime;
	private String productOrderNo;
	private String name;
	private String memberId;
	private String productInvoiceNumber;
	private Timestamp invoiceInputDate;
	private String productName;
	private String productId;
	private int productQuantity;
	private String deliveryMessage;
}

package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeliveredNoResponse {
	private Timestamp orderTime;
	private String orderNo;
	private String name;
	private String memberId;	
	private String productOrderNo;
	private String invoiceNumber;
	private Timestamp invoiceInputDate;
	private String productName;
	private String productId;
	private int productQuantity;
	private String deliveryMessage;
}

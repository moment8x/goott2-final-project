package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PendingProductResponse {
	private Timestamp orderTime;
	private String orderNo;
	private String productOrderNo;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	private int depositAmount;
	private String bankName;
	private String deliveryMessage;
}

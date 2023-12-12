package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExchangeResponse {
	private Timestamp requestTime;
	private String productOrderNo;
	private String orderNo;
	private String exchangesId;
	private String name;
	private String memberId;
	private String productName;
	private String productId;
	private int productQuantity;
	private String processingStatus;
	private String deliveryMessage;
}

package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CardCancelResponse {
	private Timestamp paymentTime;
	private Timestamp requestTime;
	private String productOrderNo;
	private String orderNo;
	private String name;
	private String memberId;
	private String paymentNumber;
	private int amount;
	private String processingStatus;
	private String deliveryMessage;
}

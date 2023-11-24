package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositNoResponse {
	private Timestamp orderTime;
	private String orderNo;
	private String productName;
	private String name;
	private String memberId;
	private String payerName;
	private int depositAmount;
	private String bankName;
	private String status;
	private String deliveryMessage;
}

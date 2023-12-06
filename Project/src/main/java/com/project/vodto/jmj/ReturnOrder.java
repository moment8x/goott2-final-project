package com.project.vodto.jmj;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class ReturnOrder {
	private String refundBank;
	private String refundAccount;
	private String accountHolder;
	private String zipNo;
	private String addr;
	private String detailAddr;
	private String returnReason;
	private int detailedOrderId;
	private String orderNo;
	private String returnMsg;
}

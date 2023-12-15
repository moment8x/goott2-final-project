package com.project.vodto.jmj;

import java.sql.Timestamp;
import java.util.List;

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
	private List<Integer> detailedOrderId;
	private String orderNo;
	private String returnMsg;
	private List<Integer> selectQty;
	private List<String> couponName;
}

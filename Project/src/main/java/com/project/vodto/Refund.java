package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Refund {
	private int refundNo;
	private String productId;
	private Timestamp refundApplicationDate;
	private Timestamp refundProcessingCompletionDate;
	private int refundNumber;
	private int totalRefundAmount;
	private int actualRefundAmount;
	private int refundRewardUsed;
	private int refundPointUsed;
	private char refundProcessingDetail;
	private String refundInformation;
}
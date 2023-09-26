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
public class Cancellation {
	private int cancelNo;
	private String productId;
	private String reason;
	private int amount;
	private int processingStatus;
	private int refundStatus;
	private Timestamp requestTime;
	private Timestamp completionTime;
}
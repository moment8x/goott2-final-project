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
public class Return {
	private int returnNo;
	private String productId;
	private String reason;
	private String processingStatus;
	private Timestamp requestTime;
	private Timestamp completionTime;
	private int refundStatus;
}
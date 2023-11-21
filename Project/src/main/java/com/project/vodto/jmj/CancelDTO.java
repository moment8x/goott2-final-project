package com.project.vodto.jmj;

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
public class CancelDTO {
	private String reason;
	private int amount;
	private int refundPointUsed;
	private int refundRewardUsed;
	private int totalRefundAmount;
}

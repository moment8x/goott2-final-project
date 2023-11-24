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
public class CancelDetailOrder {

	private int amount; //금액
	private String productId;
	private int detailedOrderId;
	private String reason;
	private String processingStatus; //처리여부
	private String refundStatus; //환불여부
	
}

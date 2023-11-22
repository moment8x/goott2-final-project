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
	private int amount; //총 환불액(금액+포인트+적립금+쿠폰)
	private int refundPointUsed; //환불 포인트
	private int refundRewardUsed; // 환불 적립금
	private int totalRefundAmount; //실제 환불금액(현금)
	private int detailedOrderId;
	private String orderNo;
	private String refundBank;
	private String refundAccount;
	private String accountHolder;
}

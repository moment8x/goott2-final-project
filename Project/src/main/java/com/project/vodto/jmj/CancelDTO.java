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
	private int amount; //할인 후 금액
	private int refundPointUsed; //환불 포인트
	private int refundRewardUsed; // 환불 적립금
	private int totalRefundAmount; //할인 전 금액
	private int detailedOrderId;
	private String orderNo;
	private String refundBank;
	private String refundAccount;
	private String accountHolder;
	private int totalQty; //취소할 총 수량
	private int orderQty; //해당 주문건의 총 수량
}

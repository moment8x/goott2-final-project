package com.project.vodto.jmj;

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
public class CancelDTO {
	private String reason;
	private int amount; //상품 * 수량
	private int refundPointUsed; //환불 포인트
	private int refundRewardUsed; // 환불 적립금
	private int totalRefundAmount; //취소하는 상품의 할인 전 금액
	private int actualRefundAmount; // 돌려줄 환불액
	private List<Integer> detailedOrderId;
	private String orderNo;
	private String refundBank;
	private String refundAccount;
	private String accountHolder;
	private int totalQty; //취소할 총 수량
	private int orderQty; //해당 주문건의 총 수량
	private List<Integer> selectQty;
	private List<String> couponName;
}

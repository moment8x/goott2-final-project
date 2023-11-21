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
public class returnOrder {
	private String ProductId;
	private int totalRefundAmount; //총 환불액(적립금, 포인트 포함)
	private int actualRefundAmount; //실 환불액(현금)
	private int refundPointUsed; // 환불 포인트
	private int refundRewardUsed; // 환불 적립금
}

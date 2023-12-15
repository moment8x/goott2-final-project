package com.project.vodto.jmj;

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

public class GetBankTransfer {
	//bank_transfers
	private String orderNo;
	private String bankName;
	private String payerName;
	private String depositedAccount; //입금계좌
	private Timestamp paymentTime; //무통장 입금 시간
	private int amountToPay; // 입금해야할 금액(실결제액)
}

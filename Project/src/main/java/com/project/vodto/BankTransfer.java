package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BankTransfer {
   private String paymentNumber;
   private String orderNo;
   private String bankName;
   private String payerName;
   private int depositAmount;
   private Timestamp paymentTime;
   private String depositedAccount;
   private int amountToPay;
}
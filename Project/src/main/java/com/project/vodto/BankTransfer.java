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
   private String payment_number;
   private int order_no;
   private String bank_name;
   private String payer_name;
   private int deposit_amount;
   private Timestamp payment_time;
   private String deposited_account;
}
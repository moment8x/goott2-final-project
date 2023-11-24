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
public class ShoppingCart {
	private int shoppingCartSeq;
	private String nonMemberId;
	private String memberId;
	private String productId;
	private int memberCheck;
	private Timestamp registrationDate;
	private int quantity;
}
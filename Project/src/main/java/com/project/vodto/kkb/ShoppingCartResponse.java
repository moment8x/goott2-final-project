package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShoppingCartResponse {
	private Timestamp registrationDate;
	private String productName;
	private int qurrentQuantity;
	private int quantity;
	private int sellingPrice;
	private int reward;
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserStorageResponse {
	private int rank;
	private String productId;
	private String productName;
	private int sellingPrice;
	private int quantity;
	private int paymentQuantity;
	private int currentQuantity;
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductRankingResponse {
	private int rank;
	private String productId;
	private String productImage;
	private String productName;
	private int sellingPrice;
	private int currentQuantity;
	private int paymentQuantity;
	private int refundQuantity;
	private float returnRate;
	private int salesQuantity;
	private int totalSales;
}

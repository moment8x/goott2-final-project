package com.project.vodto.kjs;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
public class AdminStockListVO {
	private int no;
	private String productId;
	private String productName;
	private int currentQuantity;
	private int quantity;
	private String categoryKey;
	private String categoryName;
	private String productImage;
	private int consumerPrice;
	private int salesVolume;
}
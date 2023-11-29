package com.project.service.kkb.admin;

import com.project.vodto.kkb.DepositProductResponse;

import lombok.Getter;

@Getter
public class DepositProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	private DepositProduct(String productOrderNo, String productName, String productId, int productQuantity) {
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
	}
	
	public static DepositProduct from(DepositProductResponse order) {
		return new DepositProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}
}

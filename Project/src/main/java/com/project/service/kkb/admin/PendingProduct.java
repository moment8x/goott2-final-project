package com.project.service.kkb.admin;

import com.project.vodto.kkb.PendingProductResponse;

import lombok.Getter;

@Getter
public class PendingProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	private PendingProduct(String productOrderNo, String productName, String productId, int productQuantity) {
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
	}
	
	public static PendingProduct from(PendingProductResponse order) {
		return new PendingProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}
}

package com.project.vodto.kkb;

import lombok.Getter;

@Getter
public class DeliveredInfoProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	public DeliveredInfoProduct(String productOrderNo, String productName, String productId, int productQuantity) {
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
	}
	
	public static DeliveredInfoProduct from(DeliveredNoResponse order) {
		return new DeliveredInfoProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}

}

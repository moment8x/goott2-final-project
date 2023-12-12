package com.project.vodto.kkb;

import lombok.Getter;

@Getter
public class InTransitInfoProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	public InTransitInfoProduct(String productOrderNo, String productName, String productId, int productQuantity) {
		super();
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
	}
	
	public static InTransitInfoProduct from(InTransitNoResponse order) {
		return new InTransitInfoProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}

}

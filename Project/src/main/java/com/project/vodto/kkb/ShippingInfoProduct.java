package com.project.vodto.kkb;

import lombok.Getter;

@Getter
public class ShippingInfoProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	public ShippingInfoProduct(String productOrderNo, String productName, String productId, int productQuantity) {
		super();
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
	}
	
	public static ShippingInfoProduct from(ShippingNoResponse order) {
		return new ShippingInfoProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}

}

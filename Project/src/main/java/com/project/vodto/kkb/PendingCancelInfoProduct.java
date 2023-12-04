package com.project.vodto.kkb;

import lombok.Getter;

@Getter
public class PendingCancelInfoProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	private String reason;
	
	public PendingCancelInfoProduct(String productOrderNo, String productName, String productId, 
			int productQuantity, String reason) {
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
		this.reason = reason;
	}
	
	public static PendingCancelInfoProduct from(PendingCancelResponse order) {
		return new PendingCancelInfoProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getReason());
	}

}

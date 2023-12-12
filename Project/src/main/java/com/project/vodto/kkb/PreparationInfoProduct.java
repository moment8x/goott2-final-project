package com.project.vodto.kkb;

import lombok.Getter;

@Getter
public class PreparationInfoProduct {
	private String productOrderNo;
	private String productInvoiceNumber;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	
	private PreparationInfoProduct(String productOrderNo, String productInvoiceNumber, String productName, String productId,
			int productQuantity, int productPrice) {
		this.productOrderNo = productOrderNo;
		this.productInvoiceNumber = productInvoiceNumber;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
		this.productPrice = productPrice;
	}
	
	public static PreparationInfoProduct from(PreparationNoResponse order) {
		return new PreparationInfoProduct(
				order.getProductOrderNo(),
				order.getProductInvoiceNumber(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getProductPrice());
	}
}

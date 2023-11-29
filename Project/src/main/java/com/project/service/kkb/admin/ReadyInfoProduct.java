package com.project.service.kkb.admin;

import com.project.vodto.kkb.ReadyNoResponse;

import lombok.Getter;

@Getter
public class ReadyInfoProduct {
	private String productOrderNo;
	private String productInvoiceNumber;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	
	private ReadyInfoProduct(String productOrderNo, String productInvoiceNumber, String productName, String productId,
			int productQuantity, int productPrice) {
		this.productOrderNo = productOrderNo;
		this.productInvoiceNumber = productInvoiceNumber;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
		this.productPrice = productPrice;
	}
	
	public static ReadyInfoProduct from(ReadyNoResponse order) {
		return new ReadyInfoProduct(
				order.getProductOrderNo(),
				order.getProductInvoiceNumber(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getProductPrice());
	}
}

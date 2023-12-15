package com.project.service.kkb.admin;

import com.project.vodto.kkb.OrderProductResponse;

import lombok.Getter;

@Getter
public class OrderProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	private String productStatus;
	private String productInvoiceNumber;
	
	private OrderProduct(String productOrderNo, String productName, String productId, int productQuantity,
			int productPrice, String productStatus, String productInvoiceNumber) {
		this.productOrderNo = productOrderNo;
		this.productName = productName;
		this.productId = productId;
		this.productQuantity = productQuantity;
		this.productPrice = productPrice;
		this.productStatus = productStatus;
		this.productInvoiceNumber = productInvoiceNumber;
	}
	
	public static OrderProduct from(OrderProductResponse order) {
		return new OrderProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getProductPrice(),
				order.getProductStatus(),
				order.getProductInvoiceNumber());
	}
}

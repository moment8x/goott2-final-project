package com.project.vodto.kkb;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class OrderProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	private String productStatus;
	private String invoiceNumber;
	
	public static OrderProduct from(OrderProductResponse order) {
		return new OrderProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getProductPrice(),
				order.getProductStatus(),
				order.getInvoiceNumber());
	}
}

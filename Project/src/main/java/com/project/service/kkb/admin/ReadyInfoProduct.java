package com.project.service.kkb.admin;

import com.project.vodto.kkb.ReadyNoResponse;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public class ReadyInfoProduct {
	private String productInvoiceNumber;
	private String productName;
	private String productId;
	private int productQuantity;
	private int productPrice;
	
	public static ReadyInfoProduct from(ReadyNoResponse order) {
		return new ReadyInfoProduct(
				order.getProductInvoiceNumber(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity(),
				order.getProductPrice());
	}
}

package com.project.service.kkb.admin;

import com.project.vodto.kkb.DepositProductResponse;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class DepositProduct {
	private String productOrderNo;
	private String productName;
	private String productId;
	private int productQuantity;
	
	public static DepositProduct from(DepositProductResponse order) {
		return new DepositProduct(
				order.getProductOrderNo(),
				order.getProductName(),
				order.getProductId(),
				order.getProductQuantity());
	}
}

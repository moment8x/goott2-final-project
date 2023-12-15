package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderStatus {
	private String productOrderNo;
	private String orderNo;
	private String productStatus;
	private int quantity;
	
	protected OrderStatus() {}
	
	private OrderStatus(String productOrderNo, String orderNo, String productStatus, int quantity) {
		this.productOrderNo = productOrderNo;
		this.orderNo = orderNo;
		this.productStatus = productStatus;
		this.quantity = quantity;
	}
	
	public static OrderStatus of(String productOrderNo, String orderNo, String productStatus, int quantity) {
		return new OrderStatus(productOrderNo,orderNo,productStatus,quantity);	
	}
}

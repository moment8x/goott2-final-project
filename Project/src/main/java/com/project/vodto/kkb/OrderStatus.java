package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderStatus {
	private String productOrderNo;
	private String orderNo;
	private String productStatus;
<<<<<<< HEAD

=======
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
>>>>>>> f2d8df4f6b57eee7c774879d529db917f721e2a7
}

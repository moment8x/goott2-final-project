package com.project.vodto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class DetailOrderItem {
	private int detailedOrderId;
	private String orderNo;
	private String nonOrderNo;
	private String productId;
	private int productPrice;
	private int productQuantity;
	private String productStatus;
	private String productOrderNo;

	public DetailOrderItem(String orderNo, String productId, int productQuantity) {
		// 회원 비회원 구분 필요 (나중에 추가 지금 테스트중)
		if(orderNo.substring(0, 1).equals("N")) {
			
			this.nonOrderNo = orderNo;
		} else {
			this.orderNo = orderNo;
		}
		//this.nonOrderNo = orderNo;
		this.productId = productId;
		this.productQuantity = productQuantity;
		
	}
	
	
}

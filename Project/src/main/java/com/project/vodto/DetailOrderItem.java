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
	private int couponDiscount;

	
	
	
}

package com.project.vodto.ksh;

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
public class CompleteOrderItem {
	private String orderNo;
	private String nonOrderNo;
	private String productId;
	private int productPrice;
	private int productQuantity;
	private String productName;
	private String productImage;
	private int calculatedPrice;
}

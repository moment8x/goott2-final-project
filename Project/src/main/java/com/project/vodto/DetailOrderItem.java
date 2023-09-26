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
	private int no;
	private int orderNo;
	private int nonOrderNo;
	private String productId;
	private int productPrice;
	private int coupon;
	private int discountedPrice;
}
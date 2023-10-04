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
	private int order_no;
	private int non_order_no;
	private String product_id;
	private int product_price;
	private int coupon;
	private int discounted_price;
}
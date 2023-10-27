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
	private String order_no;
	private String non_order_no;
	private String product_id;
	private int product_price;

	public DetailOrderItem(String order_no, String product_id, int product_price) {
		// 회원 비회원 구분 필요 (나중에 추가 지금 테스트중)
		if(order_no.substring(0, 1).equals("N")) {
			
			this.non_order_no = order_no;
		} else {
			this.order_no = order_no;
		}
		this.product_id = product_id;
		this.product_price = product_price;
		
	}
	
	
}

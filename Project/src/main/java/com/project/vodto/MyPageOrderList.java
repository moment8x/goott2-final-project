package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
public class MyPageOrderList {
	//order_history
	private int order_no; //주문내역
	private Timestamp order_time; //주문시간
	private String delivery_status; //배송상태
	private String invoice_number; //운송장 번호
	
//	payments
	private String actual_payment_amount; //최종금액

//	products
	private String product_image; //상품 이미지
	private String product_name; //상품 이름
}

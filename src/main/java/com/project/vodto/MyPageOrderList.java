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
	private int orderNo; //주문내역
	private Timestamp orderTime; //주문시간
	private String deliveryStatus; //배송상태
	private String invoiceNumber; //운송장 번호
	
//	payments
	private String actualPaymentAmount; //최종금액

//	products
	private String productImage; //상품 이미지
	private String productName; //상품 이름
	
	private int totalOrderCnt; //주문한 상품 총 갯수
}

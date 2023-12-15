package com.project.vodto.jmj;

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
	private String orderNo; //주문내역
	private Timestamp orderTime; //주문시간
	private String deliveryStatus; //배송상태
	private String invoiceNumber; //운송장 번호
	
//	payments
	private String actualPaymentAmount; //최종금액
	private String paymentMethod;
	
//	products
	private String productImage; //상품 이미지
	private String productName; //상품 이름
	
//	detailed_order_items
	private int totalOrderCnt; //주문한 상품 총 갯수
	private String productId; //상품아이디
	
	//bank_transfers
	private int amountToPay; //무통장 입금금액
}

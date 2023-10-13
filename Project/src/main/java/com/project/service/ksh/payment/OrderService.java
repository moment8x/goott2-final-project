package com.project.service.ksh.payment;

import com.project.vodto.NonOrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;

public interface OrderService {
	// 비회원 주문 내역 저장
//	void saveNonOrderHistory(NonOrderHistory noh) throws Exception;
	// 회원 주문 내역 저장
	
	// 주문 상세 상품 저장
	
	// 결제 해야 할 금액과 실 결제 금액 일치하는지 비교
	boolean compareAmount(PaymentDTO pd);
	
	// 결제 내역 저장
	void savePayment(PaymentDTO pd) throws Exception;

}

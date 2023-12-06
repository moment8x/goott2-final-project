package com.project.service.kkb.admin;

import java.util.List;
import java.util.Map;

import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositProductCancelRequest;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;

public interface AdminOrderService {
	 
	/* 전체 주문 조회 */
	Map<String, Object> getOrderInfo(OrderCondition orderCond);

	/* 입금 전 관리 */
	Map<String, Object> getDepositInfo(DepositCondition depositCond);

	/* 입금 전 관리 (입금 확인 버튼) */
	int editDepositConfirm(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	int editDepositOrderCancel(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	int editDepositProductCancel(List<DepositProductCancelRequest> productOrderNoList);
	
	/* 배송 준비중 관리 */
	Map<String, Object> getReadyInfo(OrderCondition readyCond);
	
	/* 배송 준비중 관리 (송장번호 저장) */
	int editInvoiceNumber(List<InvoiceCondition> invoiceCondList);
	
}

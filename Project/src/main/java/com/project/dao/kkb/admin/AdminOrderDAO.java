package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.DepositCancelInfoResponse;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;

public interface AdminOrderDAO {
	
	/* 전체 주문 조회 (주문번호별) */
	List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond) throws Exception;
	
	/* 전체 주문 조회 (품목주문별) */
	List<OrderProductResponse> findProductByInfo(OrderCondition orderCond) throws Exception;

	/* 입금 전 관리 (주문번호별) */
	List<DepositNoResponse> findDepositByInfo(DepositCondition depositCond) throws Exception;

	/* 입금 전 관리 (품목주문별) */
	List<DepositProductResponse> findDepositProductByInfo(DepositCondition depositCond) throws Exception;
	
	/* 입금 전 관리 (입금 확인 버튼 - 주문 상세 상품 상태) */
	int changeDepositConfirm(List<String> orderNoList) throws Exception;
	
	/* 입금 전 관리 (입금 확인 버튼 - 입금 확인 날짜 입력) */
	int changeDepositConfirmDate(List<String> orderNoList) throws Exception;
	
	/* 입금 전 관리 (입금 확인 버튼 - 주문 내역 상태) */
	int changeDepositConfirmHistory(List<String> orderNoList) throws Exception;
	
	/* 입금 전 관리 (주문 취소 버튼 - 주문 상세 상품 상태) */
	int changeDepositOrderCancel(List<String> orderNoList) throws Exception;

	/* 입금 전 관리 (주문 취소 버튼 - 주문 내역 상태) */
	int changeDepositOrderCancelHistory(List<String> orderNoList) throws Exception;

	/* 입금 전 관리 (주문 취소 버튼 - 취소용 추가 정보 조회) */
	List<DepositCancelInfoResponse> findDepositCancelInfo(List<String> orderNoList) throws Exception;
	
	/* 입금 전 관리 (주문 취소 버튼 - 취소 테이블에 추가) */
	int saveDepositOrderCancel(List<DepositCancelInfoResponse> cancelInfoList) throws Exception;
	
	/* 배송 준비중 관리 (주문번호별) */
	List<ReadyNoResponse> findReadyByInfo(OrderCondition readyCond) throws Exception;
	
	/* 배송 준비중 관리 (상품별) */
	List<ReadyProductResponse> findReadyProductByInfo(OrderCondition readyCond) throws Exception;

	/* 배송 준비중 관리 (상품 송장번호 저장) */
	int changeInvoiceProduct(List<InvoiceCondition> invoiceCondList) throws Exception;
	
	/* 배송 준비중 관리 (주문내역 송장번호 저장) */
	int changeInvoiceHistory(InvoiceCondition invoiceCond) throws Exception;

}

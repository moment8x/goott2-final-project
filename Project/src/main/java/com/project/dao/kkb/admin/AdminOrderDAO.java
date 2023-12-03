package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.DepositCancelInfoResponse;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductCancelRequest;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;
import com.project.vodto.kkb.ShippingNoResponse;
import com.project.vodto.kkb.ShippingProductNoResponse;
import com.project.vodto.kkb.ShippingProductResponse;

public interface AdminOrderDAO {
	
	/* 전체 주문 조회 (주문번호별) */
	List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond);
	
	/* 전체 주문 조회 (품목주문별) */
	List<OrderProductResponse> findProductByInfo(OrderCondition orderCond);

	
	/* 입금 전 관리 (조회[주문번호별]) */
	List<DepositNoResponse> findDepositByInfo(DepositCondition depositCond);

	/* 입금 전 관리 (조회[품목주문별]) */
	List<DepositProductResponse> findDepositProductByInfo(DepositCondition depositCond);
	
	
	/* 입금 전 관리 (입금 확인 버튼 - 주문 상세 상품 상태) */
	int changeDepositConfirm(List<String> orderNoList);
	
	/* 입금 전 관리 (입금 확인 버튼 - 입금 확인 날짜 입력) */
	int changeDepositConfirmDate(List<String> orderNoList);
	
	/* 입금 전 관리 (입금 확인 버튼 - 주문 내역 상태) */
	int changeDepositConfirmHistory(List<String> orderNoList);
	

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changeDepositOrderCancel(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changeDepositOrderCancelHistory(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 결제 테이블 update(column : payment_status)) */
	int changeDepositOrderCancelPayments(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changeDepositOrderCancelCoupon(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 적립금 로그 테이블 update(column : reason, balance, reward)) */
	int changeDepositOrderCancelReward(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 포인트 로그 테이블 update(column : reason, balance, point)) */
	int changeDepositOrderCancelPoint(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changeDepositOrderCancelMember(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 취소용 추가 정보 조회) */
	List<DepositCancelInfoResponse> findDepositCancelInfo(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 취소 테이블에 추가) */
	int saveDepositOrderCancel(List<DepositCancelInfoResponse> cancelInfoList);
	
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changeDepositProductCancel(List<String> productOrderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changeDepositProductCancelHistory(List<String> productOrderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 결제 테이블 update(column : payment_status)) */
	int changeDepositProductCancelPayments(List<String> productOrderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
	List<CheckedCoupons> findDepositProductCancelCoupon(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changeDepositProductCancelCoupon(List<CheckedCoupons> couponList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 적립금 로그 테이블 update(column : reason, balance, reward)) */
	int changeDepositProductCancelReward(List<String> productNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 포인트 로그 테이블 update(column : reason, balance, point)) */
	int changeDepositProductCancelPoint(List<String> productNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changeDepositProductCancelMember(List<CanceledCoupons> canceledCoupons);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 취소용 추가 정보 조회) */
	List<DepositCancelInfoResponse> findDepositProductCancelInfo(List<String> orderNoList);
	
	
	/* 배송 준비중 관리 (조회[주문번호별]) */
	List<ReadyNoResponse> findReadyByInfo(OrderCondition readyCond);
	
	/* 배송 준비중 관리 (조회[상품별]) */
	List<ReadyProductResponse> findReadyProductByInfo(OrderCondition readyCond);

	/* 배송 준비중 관리 (상품 송장번호 저장) */
	int changeInvoiceProduct(List<InvoiceCondition> invoiceCondList);
	
	/* 배송 준비중 관리 (주문내역 송장번호 저장) */
	int changeInvoiceHistory(InvoiceCondition invoiceCond);
	
	/* 배송 준비중 관리 (출고 완료 처리) */
	int changeCompleteShipment(List<String> productNoList);
	
	/* 배송 준비중 관리 (배송중 처리) */
	int changeShipped(List<String> productNoList);

	
	/* 배송 중 관리 (조회[주문번호별]) */
	List<ShippingNoResponse> findShippingByInfo(OrderCondition shippingCond);
	
	/* 배송 중 관리 (조회[품목 주문번호별]) */
	List<ShippingProductNoResponse> findShippingProductNoByInfo(OrderCondition shippingCond);
	
	/* 배송 중 관리 (조회[상품별]) */
	List<ShippingProductResponse> findShippingProductByInfo(OrderCondition shippingCond);


	
}

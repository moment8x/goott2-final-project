package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CancelResponse;
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CardCancelCondition;
import com.project.vodto.kkb.CardCancelResponse;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.DeliveredNoResponse;
import com.project.vodto.kkb.DeliveredProductNoResponse;
import com.project.vodto.kkb.DeliveredProductResponse;
import com.project.vodto.kkb.ExchangeResponse;
import com.project.vodto.kkb.InTransitNoResponse;
import com.project.vodto.kkb.InTransitProductNoResponse;
import com.project.vodto.kkb.InTransitProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.OrderStatus;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCancelInfoResponse;
import com.project.vodto.kkb.PendingCancelResponse;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.PendingNoResponse;
import com.project.vodto.kkb.PendingProductResponse;
import com.project.vodto.kkb.PreparationNoResponse;
import com.project.vodto.kkb.PreparationProductResponse;
import com.project.vodto.kkb.ProductCancelRequest;
import com.project.vodto.kkb.RefundNoInfo;
import com.project.vodto.kkb.RefundProductInfo;
import com.project.vodto.kkb.RefundResponse;
import com.project.vodto.kkb.ReturnResponse;

public interface AdminOrderDAO {
	
	/* 전체 주문 조회 (주문번호별) */
	List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond);
	
	/* 전체 주문 조회 (품목주문별) */
	List<OrderProductResponse> findProductByInfo(OrderCondition orderCond);
	
	/* 주문 상세 정보 (입금전 처리 [결제완료 -> 입금전] ) 
	 * 배송 준비중 관리 (입금전 처리[결제완료 -> 입금전] 주문번호 기준으로만 */
	int changePendingPayment(List<String> orderNoList);
	
	/* 주문 상세 정보 (상태 확인) */
	List<OrderStatus> findOrdersStatus(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (환불용 정보 저장[주문번호별]) */
	List<RefundNoInfo> findOrderRefundInfo(List<String> orderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 적립금 로그 테이블 insert) */
	int saveOrderCancelReward(List<String> orderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 포인트 로그 테이블 insert) */
	int saveOrderCancelPoint(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changeOrderCancel(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changeOrderCancelHistory(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changeOrderCancelCoupon(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changeOrderCancelMember(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 결제 테이블 update(column : payment_status)) */
	int changeOrderCancelPayments(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 취소용 추가 정보 조회) */
	List<PendingCancelInfoResponse> findCancelInfo(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 취소 테이블에 추가) */
	int saveOrderCancel(List<PendingCancelInfoResponse> cancelInfoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[주문번호별] - 환불 테이블에 추가) */
	int saveOrderCancelRefund(List<RefundNoInfo> refundInfoList);
	
	
	
	/* 주문 상세 정보 (환불용 정보 저장[품목주문별]) */
	List<RefundProductInfo> findProductRefundInfo(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 적립금 로그 테이블 insert) */
	int saveProductCancelReward(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 적립금 로그 관련 테이블 update
			결제, 회원 테이블 (column : p.used_reward, m.total_rewards, m.accumulated_use_reward)) */
	int changeProductCancelReward(List<ProductCancelRequest> productOrderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 포인트 로그 테이블 insert) */
	int saveProductCancelPoint(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 포인트 로그 테이블 update(column : reason, balance, point)) */
	int changeProductCancelPoint(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changeProductCancel(List<ProductCancelRequest> productOrderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changeProductCancelHistory(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
	List<CheckedCoupons> findProductCancelCoupon(List<String> orderNoList);

	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changeProductCancelCoupon(List<CheckedCoupons> couponList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changeProductCancelMember(List<CanceledCoupons> canceledCoupons);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 결제 테이블 update(column : payment_status)) */
	int changeProductCancelPayments(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 취소용 추가 정보 조회) */
	List<PendingCancelInfoResponse> findProductCancelInfo(List<String> orderNoList);
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 취소 테이블에 추가) */
	int saveProductCancel(List<PendingCancelInfoResponse> cancelInfoList);	
	
	/* 주문 상세 정보 (주문 취소 버튼[품목주문별] - 환불 테이블에 추가) */
	int saveProductCancelRefund(List<RefundProductInfo> refundInfoList);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 입금 전 관리 (조회[주문번호별]) */
	List<PendingNoResponse> findPendingByInfo(PendingCondition pendingCond);

	/* 입금 전 관리 (조회[품목주문별]) */
	List<PendingProductResponse> findPendingProductByInfo(PendingCondition pendingCond);
	
	
	/* 입금 전 관리 (입금 확인 버튼 - 주문 상세 상품 상태) */
	int changePreShipped(List<String> orderNoList);
	
	/* 입금 전 관리 (입금 확인 버튼 - 입금 확인 날짜 입력) */
	int changePreShippedDate(List<String> orderNoList);
	

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changePendingOrderCancel(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changePendingOrderCancelHistory(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 결제 테이블 update(column : payment_status)) */
	int changePendingOrderCancelPayments(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changePendingOrderCancelCoupon(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 적립금 로그 테이블 insert) */
	int savePendingOrderCancelReward(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 포인트 로그 테이블 update(column : reason, balance, point)) */
	int savePendingOrderCancelPoint(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changePendingOrderCancelMember(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 취소용 추가 정보 조회) */
	List<PendingCancelInfoResponse> findPendingCancelInfo(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[주문번호별] - 취소 테이블에 추가) */
	int savePendingOrderCancel(List<PendingCancelInfoResponse> cancelInfoList);
	

	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 주문 상세 상품 테이블 update(column : product_status, coupon_discount)) */
	int changePendingProductCancel(List<ProductCancelRequest> productOrderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 주문 내역 테이블 update(column : delivery_status)) */
	int changePendingProductCancelHistory(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 결제 테이블 update(column : payment_status)) */
	int changePendingProductCancelPayments(List<ProductCancelRequest> productOrderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) select) */
	List<CheckedCoupons> findPendingProductCancelCoupon(List<String> orderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 쿠폰 로그 테이블 update(column : used_date, related_order)) */
	int changePendingProductCancelCoupon(List<CheckedCoupons> couponList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 적립금 로그 테이블 insert) */
	int savePendingProductCancelReward(List<ProductCancelRequest> productOrderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 적립금 로그 테이블 update(column : reason, balance, reward)) */
	int changePendingProductCancelReward(List<ProductCancelRequest> productOrderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 포인트 로그 테이블 insert) */
	int savePendingProductCancelPoint(List<ProductCancelRequest> productOrderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 포인트 로그 테이블 update(column : reason, balance, point)) */
	int changePendingProductCancelPoint(List<ProductCancelRequest> productOrderNoList);

	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 회원 테이블 update(column : coupon_count, total_points, 
	 * 							total_rewards, accumulated_use_reward,accumulated_use_point)) */
	int changePendingProductCancelMember(List<CanceledCoupons> canceledCoupons);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 취소용 추가 정보 조회) */
	List<PendingCancelInfoResponse> findPendingProductCancelInfo(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼[품목주문별] - 취소 테이블에 추가) */
	int savePendingProductCancel(List<PendingCancelInfoResponse> cancelInfoList);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 배송 준비중 관리 (조회[주문번호별]) */
	List<PreparationNoResponse> findPreparationByInfo(OrderCondition preparationCond);
	
	/* 배송 준비중 관리 (조회[상품별]) */
	List<PreparationProductResponse> findPreparationProductByInfo(OrderCondition preparationCond);

	/* 배송 준비중 관리 (상품 송장번호 저장) */
	int changeInvoiceProduct(List<InvoiceCondition> invoiceCondList);
	
	/* 배송 준비중 관리 (주문내역 송장번호 저장) */
	int changeInvoiceHistory(InvoiceCondition invoiceCond);
	
	/* 배송 준비중 관리 (출고 완료 처리) */
	int changeShippedByNo(List<String> orderNoList);
	int changeShippedByProductNo(List<String> productNoList);

	/* 배송 준비중 관리 (배송중 처리) */
	int changeInTransitByNo(List<String> orderNoList);
	int changeInTransitByProductNo(List<String> productNoList);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 배송 중 관리 (조회[주문번호별]) */
	List<InTransitNoResponse> findInTransitByInfo(OrderCondition inTransitCond);
	
	/* 배송 중 관리 (조회[품목 주문번호별]) */
	List<InTransitProductNoResponse> findInTransitProductNoByInfo(OrderCondition inTransitCond);
	
	/* 배송 중 관리 (조회[상품별]) */
	List<InTransitProductResponse> findInTransitProductByInfo(OrderCondition inTransitCond);

	/* 배송 중 관리 (배송완료 처리[배송중 -> 배송완료]) */
	int changeDeliveredByNo(List<String> orderNoList);
	int changeDeliveredByProductNo(List<String> productNoList);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 배송 완료 조회 (조회[주문번호별]) */
	List<DeliveredNoResponse> findDeliveredByInfo(OrderCondition deliveredCond);
	
	/* 배송 완료 조회 (조회[품목 주문번호별]) */
	List<DeliveredProductNoResponse> findDeliveredProductNoByInfo(OrderCondition deliveredCond);

	/* 배송 완료 조회 (조회[상품별]) */
	List<DeliveredProductResponse> findDeliveredProductByInfo(OrderCondition deliveredCond);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 입금 전 취소 관리 (조회) */
	List<PendingCancelResponse> findPendingCancelByInfo(PendingCancelCondition pendingCancelCond);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 취소 관리 (조회) */
	List<CancelResponse> findCancelProduct(CancelCondition cancelCond);
	
/*------------------------------------------------------------------------------------------------------*/

	/* 교환 관리 (조회) */
	List<ExchangeResponse> findExchangeProduct(CancelCondition exchangeCond);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 반품 관리 (조회) */
	List<ReturnResponse> findReturnProduct(CancelCondition returnCond);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 환불 관리 (조회) */
	List<RefundResponse> findRefundProduct(CancelCondition refundCond);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 카드 취소 조회 (조회) */
	List<CardCancelResponse> findCardCancelProduct(CardCancelCondition cardCancelCond);


/*------------------------------------------------------------------------------------------------------*/
		
	

}

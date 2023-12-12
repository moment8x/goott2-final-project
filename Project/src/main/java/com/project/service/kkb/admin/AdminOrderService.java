package com.project.service.kkb.admin;

import java.util.List;
import java.util.Map;

import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CardCancelCondition;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.ProductCancelRequest;

public interface AdminOrderService {
	 
	/* 전체 주문 조회 */
	Map<String, Object> getOrderInfo(OrderCondition orderCond);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 주문 상세 정보 */
	Map<String, Object> getOrderDetailInfo(String orderNo);

	/* 주문 상세 정보 (입금전 처리 [결제완료 -> 입금전] ) 
	 * 배송 준비중 관리 (입금전 처리[결제완료 -> 입금전] */
	int editPendingPayment(List<String> orderNoList);
	
	/* 주문 상세 정보 (상태 확인) */
	int getOrdersByStatus(List<ProductCancelRequest> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 - 주문번호별) */
	int editOrderCancel(List<String> productOrderNoList);
	
	/* 주문 상세 정보 (주문 취소 - 품목주문별) */
	int editProductCancel(List<ProductCancelRequest> productOrderNoList);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 입금 전 관리 (조회) */
	Map<String, Object> getPendingInfo(PendingCondition pendingCond);

	/* 입금 전 관리 (입금 확인 [입금전 -> 결제완료] ) 
	 * 배송 준비중 관리 (결제완료 처리[출고완료 -> 결제완료]) */
	int editPreShipped(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	int editPendingOrderCancel(List<String> orderNoList);
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	int editPendingProductCancel(List<ProductCancelRequest> productOrderNoList);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 배송 준비중 관리 (조회) */
	Map<String, Object> getPreparationInfo(OrderCondition preparationCond);
	
	/* 배송 준비중 관리 (송장번호 저장) */
	int editInvoiceNumber(List<InvoiceCondition> invoiceCondList);

	/* 배송 준비중 관리 (출고완료 처리[결제완료 -> 출고완료]) 
	 * 배송 중 관리 (배송 준비중 처리[배송중 -> 출고완료]) */
	int editShippedByNo(List<String> productNoList);
	int editShippedByProductNo(List<String> productNoList);
	
	/* 배송 준비중 관리 (배송중 처리[출고완료 -> 배송중]) */
	int editInTransitByNo(List<String> orderNoList);
	int editInTransitByProductNo(List<String> productNoList);
	
	/* 배송 중 관리 (배송완료 처리[배송중 -> 배송완료]) */
	int editDeliveredByNo(List<String> orderNoList);
	int editDeliveredByProductNo(List<String> productNoList);
	
	/* 배송 중 관리 (조회) */
	Map<String, Object> getInTransitInfo(OrderCondition inTransitCond);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 배송 완료 조회 (조회) */
	Map<String, Object> getDeliveredInfo(OrderCondition deliveredCond);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 입금 전 취소 관리 (조회) */
	Map<String, Object> getPendingCancelInfo(PendingCancelCondition pendingCancelCond);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 취소 관리 (조회) */
	Map<String, Object> getCancelInfo(CancelCondition cancelCond);

	/* 취소 처리 상세정보 */
	Map<String, Object> getCancelDetailInfo(String productOrderNo);

/*------------------------------------------------------------------------------------------------------*/
	
	/* 교환 관리 (조회) */
	Map<String, Object> getExchangeInfo(CancelCondition exchangeCond);
	
/*------------------------------------------------------------------------------------------------------*/

	/* 반품 관리 (조회) */
	Map<String, Object> getReturnInfo(CancelCondition returnCond);
	
/*------------------------------------------------------------------------------------------------------*/

	/* 환불 관리 (조회) */
	Map<String, Object> getRefundInfo(CancelCondition refundCond);
	
/*------------------------------------------------------------------------------------------------------*/
	
	/* 카드 취소 조회 (조회) */
	Map<String, Object> getCardCancelInfo(CardCancelCondition cardCancelCond);


}

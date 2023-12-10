package com.project.service.kkb.admin;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CancelResponse;
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CardCancelCondition;
import com.project.vodto.kkb.CardCancelResponse;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.DeliveredInfoByProduct;
import com.project.vodto.kkb.DeliveredInfoProduct;
import com.project.vodto.kkb.DeliveredNoResponse;
import com.project.vodto.kkb.DeliveredProductNoResponse;
import com.project.vodto.kkb.DeliveredProductResponse;
import com.project.vodto.kkb.ExchangeResponse;
import com.project.vodto.kkb.InTransitInfoByProduct;
import com.project.vodto.kkb.InTransitInfoProduct;
import com.project.vodto.kkb.InTransitNoResponse;
import com.project.vodto.kkb.InTransitProductNoResponse;
import com.project.vodto.kkb.InTransitProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderByProduct;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.OrderStatus;
import com.project.vodto.kkb.PendingByProduct;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCancelInfoByProduct;
import com.project.vodto.kkb.PendingCancelInfoProduct;
import com.project.vodto.kkb.PendingCancelInfoResponse;
import com.project.vodto.kkb.PendingCancelResponse;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.PendingNoResponse;
import com.project.vodto.kkb.PendingProductResponse;
import com.project.vodto.kkb.PreparationInfoByProduct;
import com.project.vodto.kkb.PreparationInfoProduct;
import com.project.vodto.kkb.PreparationNoResponse;
import com.project.vodto.kkb.PreparationProductResponse;
import com.project.vodto.kkb.ProductCancelRequest;
import com.project.vodto.kkb.RefundNoInfo;
import com.project.vodto.kkb.RefundProductInfo;
import com.project.vodto.kkb.RefundResponse;
import com.project.vodto.kkb.ReturnResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderDao;

	/* 카드 취소 조회 (조회) */
	@Override
	public Map<String, Object> getCardCancelInfo(CardCancelCondition cardCancelCond) {

		List<CardCancelResponse> cardCancelList = adminOrderDao.findCardCancelProduct(cardCancelCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cardCancelList", cardCancelList);
		
		return result;
	}
	
	/* 환불 관리 (조회) */
	@Override
	public Map<String, Object> getRefundInfo(CancelCondition refundCond) {

		List<RefundResponse> refundList = adminOrderDao.findRefundProduct(refundCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("refundList", refundList);
		
		return result;
	}
	
	/* 반품 관리 (조회) */
	@Override
	public Map<String, Object> getReturnInfo(CancelCondition returnCond) {
		
		List<ReturnResponse> returnList = adminOrderDao.findReturnProduct(returnCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("returnList", returnList);
		
		return result;
	}


	/* 교환 관리 (조회) */
	@Override
	public Map<String, Object> getExchangeInfo(CancelCondition exchangeCond) {
		
		List<ExchangeResponse> exchangeList = adminOrderDao.findExchangeProduct(exchangeCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("exchangeList", exchangeList);
		
		return result;
	}
	
	/* 취소 처리 상세정보 */
	@Override
	public Map<String, Object> getCancelDetailInfo(String productOrderNo) {
		// TODO Auto-generated method stub
		return null;
	}

	/* 취소 관리 (조회) */
	@Override
	public Map<String, Object> getCancelInfo(CancelCondition cancelCond) {
		
		List<CancelResponse> cancelList = adminOrderDao.findCancelProduct(cancelCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cancelList", cancelList);
		
		return result;
	}
	
	/* 입금 전 취소 관리 (조회) */
	@Override
	public Map<String, Object> getPendingCancelInfo(PendingCancelCondition pendingCancelCond) {
		
		List<PendingCancelInfoByProduct> pendingCancelList = 
				getPendingCancelByProduct(pendingCancelCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("pendingCancelList", pendingCancelList);
		
		return result;
	}
	
	/* 배송 중 관리 (배송완료 처리[배송중 -> 배송완료]) */
	@Override
	public int editDeliveredByNo(List<String> orderNoList) {
		return adminOrderDao.changeDeliveredByNo(orderNoList);
	}
	@Override
	public int editDeliveredByProductNo(List<String> productNoList) {
		return adminOrderDao.changeDeliveredByProductNo(productNoList);
	}

	/* 배송 완료 조회 (조회) */
	@Override
	public Map<String, Object> getDeliveredInfo(OrderCondition deliveredCond) {
		
		List<DeliveredInfoByProduct> deliveredOrderList = getDeliveredByProduct(deliveredCond);
		
		List<DeliveredProductNoResponse> deliveredProductNoList = 
				adminOrderDao.findDeliveredProductNoByInfo(deliveredCond);
		
		List<DeliveredProductResponse> deliveredProductList = 
				adminOrderDao.findDeliveredProductByInfo(deliveredCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("deliveredOrderList", deliveredOrderList);
		result.put("deliveredProductNoList", deliveredProductNoList);
		result.put("deliveredProductList", deliveredProductList);
		
		return result;
	}
	
	/* 배송 중 관리(조회) */
	@Override
	public Map<String, Object> getInTransitInfo(OrderCondition inTransitCond) {
		
		List<InTransitInfoByProduct> inTransitOrderList = getInTransitByProduct(inTransitCond);
		
		List<InTransitProductNoResponse> inTransitProductNoList = 
				adminOrderDao.findInTransitProductNoByInfo(inTransitCond);
		
		List<InTransitProductResponse> inTransitProductList = 
				adminOrderDao.findInTransitProductByInfo(inTransitCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("inTransitOrderList", inTransitOrderList);
		result.put("inTransitProductNoList", inTransitProductNoList);
		result.put("inTransitProductList", inTransitProductList);
		
		return result;
	}

	/* 배송 준비중 관리 (배송중 처리[출고완료 -> 배송중]) */
	@Override
	public int editInTransitByNo(List<String> orderNoList) {
		return adminOrderDao.changeInTransitByNo(orderNoList);
	}
	@Override
	public int editInTransitByProductNo(List<String> productNoList) {
		return adminOrderDao.changeInTransitByProductNo(productNoList);
	}

	/* 배송 준비중 관리 (출고완료 처리[결제완료 -> 출고완료]) 
	 * 배송 중 관리 (배송 준비중 처리[배송중 -> 출고완료]) */
	@Override
	public int editShippedByNo(List<String> orderNoList) {
		return adminOrderDao.changeShippedByNo(orderNoList);
	}
	@Override
	public int editShippedByProductNo(List<String> productNoList) {
		return adminOrderDao.changeShippedByProductNo(productNoList);
	}
	
	/* 배송 준비중 관리(송장 번호 업데이트) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editInvoiceNumber(List<InvoiceCondition> invoiceCondList) {
		
		int result = -1;
		
		if(invoiceCondList != null && !invoiceCondList.isEmpty()) {
			
			InvoiceCondition invoiceCond = invoiceCondList.get(0);
			/* 주문 상세 상품 및 주문내역 테이블 송장 번호 업데이트 */
			if(adminOrderDao.changeInvoiceProduct(invoiceCondList) > 0) {
				adminOrderDao.changeInvoiceHistory(invoiceCond);
				result = invoiceCondList.size();
			}
		}
		return result;
	}
	
	/* 배송 준비중 관리 (조회) */
	@Override
	public Map<String, Object> getPreparationInfo(OrderCondition preparationCond) {
		
		List<PreparationInfoByProduct> preparationOrderList = 
				getPreparationByProduct(preparationCond);
		
		List<PreparationProductResponse> preparationProductList = 
				adminOrderDao.findPreparationProductByInfo(preparationCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("preparationOrderList", preparationOrderList);
		result.put("preparationOrderNoList", preparationOrderList);
		result.put("preparationProductList", preparationProductList);
		
		return result;
	}
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editPendingProductCancel(List<ProductCancelRequest> productOrderNoList) {
		
		int result = -1;
		
		List<String> orderNoList = productOrderNoList.stream()
    			.collect(Collectors.groupingBy(ProductCancelRequest::getConvertedOrderNo))
	            .entrySet().stream()
	            .map(order -> order.getKey())
	            .collect(Collectors.toList());
		
		List<String> productNoList = productOrderNoList.stream()
				.map(ProductCancelRequest::getProductOrderNo)	
				.collect(Collectors.toList());
	
		/* 적립금 로그 테이블 insert */
		if(adminOrderDao.savePendingProductCancelReward(productOrderNoList) > 0) {
			/* 적립금 로그 테이블 update(column : reason, balance, reward) 
			 * 회원 테이블 update(column : total_rewards, accumulated_use_reward) */
			if(adminOrderDao.changePendingProductCancelReward(productOrderNoList) <= 0 ) {
				return result;
			}
		}			
		
		/* 포인트 로그 테이블 insert */
		if(adminOrderDao.savePendingProductCancelPoint(productOrderNoList) > 0) {
			/* 포인트 로그 테이블 update(column : reason, balance, point) 
			 * 회원 테이블 update(column : total_points, accumulated_use_point) */
			if(adminOrderDao.changePendingProductCancelPoint(productOrderNoList) <= 0 ) {
				return result;
			}
		}
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changePendingProductCancel(productOrderNoList) <= 0 ) {
			return result;
		}
		
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changePendingProductCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) 확인하기 위해 select) */
		List<CheckedCoupons> couponList = adminOrderDao.findPendingProductCancelCoupon(orderNoList);
		
		if(!couponList.isEmpty()) {
			/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
			adminOrderDao.changePendingProductCancelCoupon(couponList); // 적용 쿠폰 수가 0일 때만 돌려줌
		
			/* 회원 테이블 update(column : coupon_count) */
			List<CanceledCoupons> canceledCoupons = CanceledCoupons.convert(couponList);
			if(adminOrderDao.changePendingProductCancelMember(canceledCoupons) <= 0) {
				return result;
			}
		}		
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changePendingProductCancelPayments(productOrderNoList) > 0) {
			List<PendingCancelInfoResponse> cancelInfoList = 
					adminOrderDao.findPendingProductCancelInfo(productNoList);
			
			cancelInfoList.forEach(cancelInfo -> {
	            productOrderNoList.stream()
	                .filter(request -> cancelInfo.getProductOrderNo().equals(request.getProductOrderNo()))
	                .findFirst()
	                .ifPresent(request -> cancelInfo.setQuantity(request.getQuantity()));
	        });	
			
			/* 취소 테이블 insert */
			result = adminOrderDao.savePendingProductCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editPendingOrderCancel(List<String> orderNoList) {
		
		int result = -1;
		
		/* 적립금 로그 테이블 insert */
		adminOrderDao.savePendingOrderCancelReward(orderNoList);
		
		/* 포인트 로그 테이블 update(column : reason, balance, point) */
		adminOrderDao.savePendingOrderCancelPoint(orderNoList);
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changePendingOrderCancel(orderNoList) <= 0 ) {
			return result;
		}
		
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changePendingOrderCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		if(adminOrderDao.changePendingOrderCancelCoupon(orderNoList) <= 0) {
			return result;
		}
		
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * 							accumulated_use_reward,accumulated_use_point ) */
		if(adminOrderDao.changePendingOrderCancelMember(orderNoList) <= 0) {
			return result;
		}
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changePendingOrderCancelPayments(orderNoList) > 0) {
			List<PendingCancelInfoResponse> cancelInfoList = 
					adminOrderDao.findPendingCancelInfo(orderNoList);
			
			/* 취소 테이블 insert */
			result = adminOrderDao.savePendingOrderCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금 전 관리 (입금 확인 [입금전 -> 결제완료] ) 
	 * 배송 준비중 관리 (결제완료 처리[출고완료 -> 결제완료]) 주문번호 기준으로만 */  
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editPreShipped(List<String> orderNoList) {
		
		int result = -1;
		
		/* 주문 상세 상품, 주문내역, 결제 테이블 상태 업데이트 */
		if(adminOrderDao.changePreShipped(orderNoList) > 0 ) {
			/* 무통장 입금 테이블에 입금 확인 날짜 업데이트 */
			result = adminOrderDao.changePreShippedDate(orderNoList);
		}
		return result;
	}	
	
	/* 입금전 관리 (조회) */
	@Override
	public Map<String, Object> getPendingInfo(PendingCondition pendingCond) {
		
		List<PendingNoResponse> pendingOrderList = adminOrderDao.findPendingByInfo(pendingCond);
		List<PendingByProduct> pendingProductList = getPendingByProduct(pendingCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("pendingOrderList", pendingOrderList);
		result.put("pendingProductList", pendingProductList);
		
		return result;
	}
	
	/* 주문 상세 정보 (결제 완료 상태 이후 주문 취소 - 품목주문별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editProductCancel(List<ProductCancelRequest> productOrderNoList) {
		
		int result = -1;
			
		List<String> orderNoList = productOrderNoList.stream()
    			.collect(Collectors.groupingBy(ProductCancelRequest::getConvertedOrderNo))
	            .entrySet().stream()
	            .map(order -> order.getKey())
	            .collect(Collectors.toList());
		
		List<String> productNoList = productOrderNoList.stream()
				.map(ProductCancelRequest::getProductOrderNo)	
				.collect(Collectors.toList());
	
		/* 환불용 정보 select */
		List<RefundProductInfo> refundInfoList = adminOrderDao.findProductRefundInfo(productOrderNoList);
		
		/* 적립금 로그 테이블 insert */
		if(adminOrderDao.saveProductCancelReward(productOrderNoList) > 0 ) {
			/* 적립금 로그 테이블 update(column : reason, balance, reward) 
			 * 회원 테이블 update(column : total_rewards, accumulated_use_reward) */
			if(adminOrderDao.changeProductCancelReward(productOrderNoList) <= 0) {
				return result;
			}
		}
		
		/* 포인트 로그 테이블 insert */
		if(adminOrderDao.saveProductCancelPoint(productOrderNoList) > 0 ) {
			/* 포인트 로그 테이블 update(column : reason, balance, point) 
			 * 회원 테이블 update(column : total_points, accumulated_use_point) */
			if(adminOrderDao.changeProductCancelPoint(productOrderNoList) <= 0) {
				return result;
			}
		}
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changeProductCancel(productOrderNoList) <= 0 ) {
			return result;
		}
		
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changeProductCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) 확인하기 위해 select) */
		List<CheckedCoupons> couponList = adminOrderDao.findProductCancelCoupon(orderNoList);
		
		if(!couponList.isEmpty()) {
			/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
			adminOrderDao.changeProductCancelCoupon(couponList); // 적용 쿠폰 수가 0일 때만 돌려줌
			
			/* 회원 테이블 update(column : coupon_count) */
			List<CanceledCoupons> canceledCoupons = CanceledCoupons.convert(couponList);
			if(adminOrderDao.changeProductCancelMember(canceledCoupons) <= 0) {
				return result;
			}
		}
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changeProductCancelPayments(productOrderNoList) <= 0) {
			return result;
	    };
	    
	    List<PendingCancelInfoResponse> cancelInfoList = adminOrderDao.findProductCancelInfo(productNoList);
	    
	    List<PendingCancelInfoResponse> methodBankList = cancelInfoList
				.stream().filter(order -> order.getPaymentMethod().equals("bkt"))
				.collect(Collectors.toList());
				
		List<PendingCancelInfoResponse> methodCardList = cancelInfoList
				.stream().filter(order -> !order.getPaymentMethod().equals("bkt"))
				.collect(Collectors.toList());
			    
		if(!methodBankList.isEmpty()) {
			/* 취소 테이블 insert */
			if(adminOrderDao.saveProductCancel(methodCardList) <= 0) {
				return result;
			}
		}
		
		if(!methodCardList.isEmpty()) {
			/* 취소 테이블 insert */
			if(adminOrderDao.saveProductCancel(cancelInfoList) > 0) {
				refundInfoList.forEach(info -> {
					methodCardList.stream()
		                .filter(request -> info.getProductOrderNo().equals(request.getProductOrderNo()))
		                .findFirst()
		                .ifPresent(request -> info.setCancelId(request.getCancelId()));
		        });	
				refundInfoList.removeIf(info -> info.getCancelId() == null);
				
				/* 환불 테이블 insert */
				result = adminOrderDao.saveProductCancelRefund(refundInfoList);
			}
		}		
		return result;
	}
	
	/* 주문 상세 정보 (결제 완료 상태 이후 주문 취소 - 주문번호별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editOrderCancel(List<String> orderNoList) {
		
		int result = -1;
		
		/* 환불용 정보 select */
		List<RefundNoInfo> refundInfoList = adminOrderDao.findOrderRefundInfo(orderNoList);
		
		/* 적립금 로그 테이블 insert */
		adminOrderDao.saveOrderCancelReward(orderNoList);
		
		/* 포인트 로그 테이블 insert */
		adminOrderDao.saveOrderCancelPoint(orderNoList);
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changeOrderCancel(orderNoList) <= 0 ) {
			return result;
		}
		
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changeOrderCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		if(adminOrderDao.changeOrderCancelCoupon(orderNoList) <= 0) {
			return result;
		}
		
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * 							accumulated_use_reward,accumulated_use_point ) */
		if(adminOrderDao.changeOrderCancelMember(orderNoList) <= 0) {
			return result;
		}
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changeOrderCancelPayments(orderNoList) <= 0) {
			return result;
		}
		
		List<PendingCancelInfoResponse> cancelInfoList = adminOrderDao.findCancelInfo(orderNoList);
		
		List<PendingCancelInfoResponse> methodBankList = cancelInfoList
				.stream().filter(order -> order.getPaymentMethod().equals("bkt"))
				.collect(Collectors.toList());
				
		List<PendingCancelInfoResponse> methodCardList = cancelInfoList
				.stream().filter(order -> !order.getPaymentMethod().equals("bkt"))
				.collect(Collectors.toList());
				
		if(!methodBankList.isEmpty()) {
			/* 취소 테이블 insert */
			if(adminOrderDao.saveOrderCancel(methodCardList) <= 0) {
				return result;
			}
		}
		
		if(!methodCardList.isEmpty()) {
			/* 취소 테이블 insert */
			if(adminOrderDao.saveOrderCancel(methodCardList) > 0) {
				refundInfoList.forEach(info ->
			    methodCardList.stream()
			        .filter(request -> info.getProductOrderNo().equals(request.getProductOrderNo()))
			        .findFirst()
			        .ifPresent(
			            matchingCard -> info.setCancelId(matchingCard.getCancelId())
			        )
				);
				refundInfoList.removeIf(info -> info.getCancelId() == null);
				
				/* 환불 테이블 insert */
				result = adminOrderDao.saveOrderCancelRefund(refundInfoList);
			}
		}
		
		return result;
	}
	
	/* 주문 상세 정보 (취소전 상태 확인 -> 상태에 맞는 취소 실행) */
	@Override
	public int getOrdersByStatus(List<ProductCancelRequest> productOrderNoList) {
		
		List<OrderStatus> filterPendingByOrderNo = adminOrderDao.findOrdersStatus(productOrderNoList);

		List<OrderStatus> updatedList = filterPendingByOrderNo.stream()
                .map(orderInfo -> {
                    ProductCancelRequest request = productOrderNoList.stream()
                            .filter(cancel -> cancel.getProductOrderNo().equals(orderInfo.getProductOrderNo()))
                            .findFirst()
                            .orElse(new ProductCancelRequest()); 
                    orderInfo.setQuantity(request.getQuantity());

                    return orderInfo;
                })
                .collect(Collectors.toList());
		
		List<String> pendingOrderNo = filterPendingByOrderNo(filterPendingByOrderNo);
		List<ProductCancelRequest> pendingProductNo = filterPendingByProductNo(updatedList);
		List<String> shippedOrderNo = filterPreShippedByOrderNo(filterPendingByOrderNo);
		List<ProductCancelRequest> shippedProductNo = filterShippedByProductNo(updatedList);
		 
		if(!pendingOrderNo.isEmpty()) { 
			editPendingOrderCancel(pendingOrderNo);
		}
		
		if(!pendingProductNo.isEmpty()) { 
			editPendingProductCancel(pendingProductNo);
		}
		
		if(!shippedOrderNo.isEmpty()) { 
			editOrderCancel(shippedOrderNo);
		}
		
		if(!shippedProductNo.isEmpty()) { 
			editProductCancel(shippedProductNo);
		}
		
		return pendingOrderNo.size() + pendingProductNo.size() + shippedOrderNo.size() + shippedProductNo.size();
	}
	
	/* 주문 상세 정보 (입금전 처리 [결제완료 -> 입금전] ) 
	 * 배송 준비중 관리 (입금전 처리[결제완료 -> 입금전] 주문번호 기준으로만 */
	@Override
	public int editPendingPayment(List<String> orderNoList) {
		return adminOrderDao.changePendingPayment(orderNoList);
	}
	
	/* 주문 상세 정보 */
	@Override
	public Map<String, Object> getOrderDetailInfo(String orderNo) {
		
//		List<OrderDetailResponse> orderDetailList = adminOrderDao.findOrderDetailInfo(orderNo);
//		List<OrderDetailEtcResponse> orderDetailList = adminOrderDao.findOrderDetailEtc(orderNo);
//		
//		Map<String, Object> result = new HashMap<>();
//		result.put("orderDetailList", orderDetailList);
//		
//		return result;
		return null;
	}
	
	/* 전체 주문 조회 */
	@Override
	public Map<String, Object> getOrderInfo(OrderCondition orderCond) {
		
		List<OrderNoResponse> orderList = adminOrderDao.findOrderByInfo(orderCond);
		List<OrderByProduct> productList = getOrderByProduct(orderCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("orderNoList", orderList);
		result.put("productList", productList);
		
		return result;
	}
	
/*----------------------------------------------------------------------------------------------------------------*/
	
	/* 입금전 상태만 남김 (주문번호 기준)*/
	private List<String> filterPendingByOrderNo(List<OrderStatus> orderStatusList) {
		
		/* OrderNO 안에 다른 상태인 상품이 들어있으면 제외 */
		List<String> exclusionOrderNo = Optional.ofNullable(orderStatusList.stream()
    			.filter(e -> !e.getProductStatus().equals("입금전"))
    			.map(OrderStatus::getOrderNo)
    			.collect(Collectors.toList()))
    			.orElseGet(Collections::emptyList);
		
    	/* 입금 전 상태인 OrderNo */
    	List<String> pendingOrderNo = orderStatusList.stream()
    			.filter(e -> exclusionOrderNo.stream()
    					.noneMatch(Predicate.isEqual(e.getOrderNo())))
    					.filter(e -> e.getProductStatus().equals("입금전") && e.getProductOrderNo() == null)
    					.map(OrderStatus::getOrderNo)
	    				.distinct()
	    				.collect(Collectors.toList());
	
    	return pendingOrderNo;
	}
	
	/* 입금전 상태만 남김 (품목별 주문번호 기준)*/
	private List<ProductCancelRequest> filterPendingByProductNo(List<OrderStatus> orderStatusList) {
		
		/* 입금 전 상태인 ProductNo */
    	List<ProductCancelRequest> pendingProductNo = orderStatusList.stream()
    					.filter(e -> e.getProductStatus().equals("입금전") && e.getOrderNo() == null)
    					.map(OrderStatus::getProductOrderNo)
    					.map(ProductCancelRequest::of)
	    				.collect(Collectors.toList());
	
    	return pendingProductNo;
	}
	
	/* 결제완료 상태만 남김 (주문번호 기준)*/
	private List<String> filterPreShippedByOrderNo(List<OrderStatus> orderStatusList) {
			
		/* OrderNO 안에 다른 상태인 상품이 들어있으면 제외 */
    	List<String> exclusionPreShippedOrderNo = Optional.ofNullable(orderStatusList.stream()
    			.filter(e -> !e.getProductStatus().equals("결제완료"))
    			.map(OrderStatus::getOrderNo)
    			.collect(Collectors.toList()))
    			.orElseGet(Collections::emptyList);
		
    	/* 결제완료 상태인 OrderNo */
    	List<String> preShippedOrderNo = orderStatusList.stream()
    			.filter(e -> exclusionPreShippedOrderNo.stream()
    					.noneMatch(Predicate.isEqual(e.getOrderNo())))
    					.filter(e -> e.getProductStatus().equals("결제완료") && e.getProductOrderNo() == null)
    					.map(OrderStatus::getOrderNo)
	    				.distinct()
	    				.collect(Collectors.toList());
	
    	return preShippedOrderNo;
	}
	
	/* 결제완료 상태만 남김 (품목별 주문번호 기준)*/
	private List<ProductCancelRequest> filterShippedByProductNo(List<OrderStatus> orderStatusList) {
				
		/* 결제완료 상태인 ProductNo */
    	List<ProductCancelRequest> preShippedProductNo = orderStatusList.stream()
				.filter(e -> e.getProductStatus().equals("결제완료") && e.getOrderNo() == null)
				.map(OrderStatus::getProductOrderNo)
				.map(ProductCancelRequest::of)
				.collect(Collectors.toList());
	
    	return preShippedProductNo;
	}
	
	
	/* 특정 필드만 그룹화 */
	private List<OrderByProduct> getOrderByProduct(OrderCondition orderCond) {
	    
		List<OrderProductResponse> list = adminOrderDao.findProductByInfo(orderCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(OrderProductResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<OrderProduct> orders = order.getValue()
	                        .stream()
	                        .map(OrderProduct::from)
	                        .collect(Collectors.toList());

	                OrderProductResponse info = order.getValue().get(0);

	                return new OrderByProduct(
	                        info.getOrderTime(),
	                        info.getPaymentTime(),
	                        orderNo,
	                        info.getName(),
	                        info.getMemberId(),
	                        info.getActualPaymentAmount(),
	                        info.getPaymentMethod(),
	                        info.getPaymentStatus(),
	                        info.getDeliveryMessage(),
	                        orders
	                );
	            })
	            .collect(Collectors.toList());
	}
	
	/* 특정 필드만 그룹화 */
	private List<PendingByProduct> getPendingByProduct(PendingCondition pendingCond) {
		    
			List<PendingProductResponse> list = adminOrderDao.findPendingProductByInfo(pendingCond);
	
		    return list.stream()
		            .collect(Collectors.groupingBy(PendingProductResponse::getOrderNo))
		            .entrySet().stream()
		            .map(order -> {
		                String orderNo = order.getKey();
		                List<PendingProduct> orders = order.getValue()
		                        .stream()
		                        .map(PendingProduct::from)
		                        .collect(Collectors.toList());
	
		                PendingProductResponse info = order.getValue().get(0);
	
		                return new PendingByProduct(
		                        info.getOrderTime(),
		                        orderNo,
		                        info.getName(),
		                        info.getMemberId(),
		                        info.getDepositAmount(),
		                        info.getBankName(),
		                        info.getDeliveryMessage(),
		                        orders
		                );
		            })
		            .collect(Collectors.toList());
	}
	
	/* 특정 필드만 그룹화 */
	private List<PreparationInfoByProduct> getPreparationByProduct(OrderCondition preparationCond) {
	    
		List<PreparationNoResponse> list = adminOrderDao.findPreparationByInfo(preparationCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(PreparationNoResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<PreparationInfoProduct> orders = order.getValue()
	                        .stream()
	                        .map(PreparationInfoProduct::from)
	                        .collect(Collectors.toList());

	                PreparationNoResponse info = order.getValue().get(0);

	                return new PreparationInfoByProduct(
	                        info.getOrderTime(),
	                        info.getPaymentTime(),
	                        orderNo,
	                        info.getName(),
	                        info.getMemberId(),
	                        info.getProductStatus(),
	                        info.getActualPaymentAmount(),
	                        info.getPaymentMethod(),
	                        info.getDeliveryMessage(),
	                        orders
	                );
	            })
	            .collect(Collectors.toList());
	}
	
	/* 특정 필드만 그룹화 */
	private List<InTransitInfoByProduct> getInTransitByProduct(OrderCondition inTransitCond) {
		
		List<InTransitNoResponse> list = adminOrderDao.findInTransitByInfo(inTransitCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(InTransitNoResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<InTransitInfoProduct> orders = order.getValue()
	                        .stream()
	                        .map(InTransitInfoProduct::from)
	                        .collect(Collectors.toList());

	                InTransitNoResponse info = order.getValue().get(0);

	                return new InTransitInfoByProduct(
	                        info.getOrderTime(),
	                        orderNo,
	                        info.getName(),
	                        info.getMemberId(),
	                        info.getInvoiceNumber(),
	                        info.getDeliveryMessage(),
	                        orders
	                );
	            })
	            .collect(Collectors.toList());
	}
	
	/* 특정 필드만 그룹화 */
	private List<DeliveredInfoByProduct> getDeliveredByProduct(OrderCondition deliveredCond) {
		
		List<DeliveredNoResponse> list = adminOrderDao.findDeliveredByInfo(deliveredCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(DeliveredNoResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<DeliveredInfoProduct> orders = order.getValue()
	                        .stream()
	                        .map(DeliveredInfoProduct::from)
	                        .collect(Collectors.toList());

	                DeliveredNoResponse info = order.getValue().get(0);

	                return new DeliveredInfoByProduct(
	                        info.getOrderTime(),
	                        orderNo,
	                        info.getName(),
	                        info.getMemberId(),
	                        info.getInvoiceNumber(),
	                        info.getDeliveryMessage(),
	                        orders
	                );
	            })
	            .collect(Collectors.toList());
	}
	
	/* 특정 필드만 그룹화 */
	private List<PendingCancelInfoByProduct> getPendingCancelByProduct(PendingCancelCondition deliveredCond) {
			
			List<PendingCancelResponse> list = adminOrderDao.findPendingCancelByInfo(deliveredCond);
	
		    return list.stream()
		            .collect(Collectors.groupingBy(PendingCancelResponse::getOrderNo))
		            .entrySet().stream()
		            .map(order -> {
		                String orderNo = order.getKey();
		                List<PendingCancelInfoProduct> orders = order.getValue()
		                        .stream()
		                        .map(PendingCancelInfoProduct::from)
		                        .collect(Collectors.toList());
	
		                PendingCancelResponse info = order.getValue().get(0);
	
		                return new PendingCancelInfoByProduct(
		                        info.getOrderTime(),
		                        info.getRequestTime(),
		                        orderNo,
		                        info.getName(),
		                        info.getMemberId(),
		                        info.getAmountToPay(),
		                        info.getPaymentMethod(),
		                        info.getDeliveryMessage(),
		                        orders
		                );
		            })
		            .collect(Collectors.toList());
		}


}

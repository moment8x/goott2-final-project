package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.DepositByProduct;
import com.project.vodto.kkb.DepositCancelInfoResponse;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductCancelRequest;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderByProduct;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.ReadyInfoByProduct;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderRepository;
	
	/* 송장 번호 업데이트 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editInvoiceNumber(List<InvoiceCondition> invoiceCondList) {
		
		int result = -1;
		
		if(invoiceCondList != null && !invoiceCondList.isEmpty()) {
			
			InvoiceCondition invoiceCond = invoiceCondList.get(0);
			/* 주문 상세 상품 및 주문내역 테이블 송장 번호 업데이트 */
			if(adminOrderRepository.changeInvoiceProduct(invoiceCondList) > 0) {
				adminOrderRepository.changeInvoiceHistory(invoiceCond);
				result = invoiceCondList.size();
			}
		}
		return result;
	}
	
	@Override
	public Map<String, Object> getOrderInfo(OrderCondition orderCond) {
		
		List<OrderNoResponse> orderList = adminOrderRepository.findOrderByInfo(orderCond);
		List<OrderByProduct> productList = getOrderByProduct(orderCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("orderNoList", orderList);
		result.put("productList", productList);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getDepositInfo(DepositCondition depositCond) {
		
		List<DepositNoResponse> depositOrderList = adminOrderRepository.findDepositByInfo(depositCond);
		List<DepositByProduct> depositProductList = getDepositByProduct(depositCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("depositOrderList", depositOrderList);
		result.put("depositProductList", depositProductList);
		
		return result;
	}
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositProductCancel(List<DepositProductCancelRequest> productOrderNoList) {
		
		int result = -1;
		
		List<DepositProductCancelRequest> convertedNoList = 
				productOrderNoList.stream()
					.map(info -> {
							info.setConvertedOrderNo();
							return info;
						})
					.collect(Collectors.toList());
	
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderRepository.changeDepositProductCancel(productOrderNoList) <= 0 ) {
			return result;
		}
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderRepository.changeDepositProductCancelHistory(convertedNoList) <= 0) {
			return result;
		}
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderRepository.changeDepositProductCancelPayments(productOrderNoList) <= 0) {
			return result;
		}
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		if(adminOrderRepository.changeDepositProductCancelCoupon(productOrderNoList) <= 0) {
			return result;
		}
		/* 적립금 로그 테이블 update(column : reason, balance, reward) */
		if(adminOrderRepository.changeDepositProductCancelReward(productOrderNoList) <= 0) {
			return result;
		}
		/* 포인트 로그 테이블 update(column : reason, balance, point) */
		if(adminOrderRepository.changeDepositProductCancelPoint(productOrderNoList) <= 0) {
			return result;
		}
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * accumulated_reward, accumulated_use_reward, accumulated_pointm, accumulated_use_point ) */
		if(adminOrderRepository.changeDepositProductCancelMember(productOrderNoList) > 0) {
			
			List<String> orderNoList = productOrderNoList.stream()
					.map(DepositProductCancelRequest::getConvertedOrderNo)	
					.collect(Collectors.toList());
							
			List<DepositCancelInfoResponse> cancelInfoList = 
					adminOrderRepository.findDepositCancelInfo(orderNoList);
			
			result = adminOrderRepository.saveDepositOrderCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositOrderCancel(List<String> orderNoList) {
		
		int result = -1;
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderRepository.changeDepositOrderCancel(orderNoList) <= 0 ) {
			return result;
		}
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderRepository.changeDepositOrderCancelHistory(orderNoList) <= 0) {
			return result;
		}
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderRepository.changeDepositOrderCancelPayments(orderNoList) <= 0) {
			return result;
		}
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		if(adminOrderRepository.changeDepositOrderCancelCoupon(orderNoList) <= 0) {
			return result;
		}
		/* 적립금 로그 테이블 update(column : reason, balance, reward) */
		if(adminOrderRepository.changeDepositOrderCancelReward(orderNoList) <= 0) {
			return result;
		}
		/* 포인트 로그 테이블 update(column : reason, balance, point) */
		if(adminOrderRepository.changeDepositOrderCancelPoint(orderNoList) <= 0) {
			return result;
		}
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * accumulated_reward, accumulated_use_reward, accumulated_pointm, accumulated_use_point ) */
		if(adminOrderRepository.changeDepositOrderCancelMember(orderNoList) > 0) {
			
			List<DepositCancelInfoResponse> cancelInfoList = 
					adminOrderRepository.findDepositCancelInfo(orderNoList);
			
			result = adminOrderRepository.saveDepositOrderCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금전 관리 - 입금 확인 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositConfirm(List<String> orderNoList) {
		
		int result = -1;
		
		/* 주문 상세 상품, 주문내역 테이블 상태 업데이트 */
		if(adminOrderRepository.changeDepositConfirm(orderNoList) <= 0 ) {
			return result;
		}
		
		if(adminOrderRepository.changeDepositConfirmHistory(orderNoList) > 0) {
			/* 주문 상세 상품 테이블에 송장 번호 입력일 업데이트 */
			result = adminOrderRepository.changeDepositConfirmDate(orderNoList);
		}
		
		return result;
	}
	
	@Override
	public Map<String, Object> getReadyInfo(OrderCondition readyCond) {
		
		List<ReadyInfoByProduct> readyOrderList = getReadyByProduct(readyCond);
		List<ReadyProductResponse> readyProductList = adminOrderRepository.findReadyProductByInfo(readyCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("readyOrderList", readyOrderList);
		result.put("readyProductList", readyProductList);
		
		return result;
	}
	
		
	private List<OrderByProduct> getOrderByProduct(OrderCondition orderCond) {
	    
		List<OrderProductResponse> list = adminOrderRepository.findProductByInfo(orderCond);

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

	private List<DepositByProduct> getDepositByProduct(DepositCondition depositCond) {
		    
			List<DepositProductResponse> list = adminOrderRepository.findDepositProductByInfo(depositCond);
	
		    return list.stream()
		            .collect(Collectors.groupingBy(DepositProductResponse::getOrderNo))
		            .entrySet().stream()
		            .map(order -> {
		                String orderNo = order.getKey();
		                List<DepositProduct> orders = order.getValue()
		                        .stream()
		                        .map(DepositProduct::from)
		                        .collect(Collectors.toList());
	
		                DepositProductResponse info = order.getValue().get(0);
	
		                return new DepositByProduct(
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
	
	private List<ReadyInfoByProduct> getReadyByProduct(OrderCondition readyCond) {
	    
		List<ReadyNoResponse> list = adminOrderRepository.findReadyByInfo(readyCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(ReadyNoResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<ReadyInfoProduct> orders = order.getValue()
	                        .stream()
	                        .map(ReadyInfoProduct::from)
	                        .collect(Collectors.toList());

	                ReadyNoResponse info = order.getValue().get(0);

	                return new ReadyInfoByProduct(
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
}

package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CheckedCoupons;
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
import com.project.vodto.kkb.ReadyInfoProduct;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;
import com.project.vodto.kkb.ShippingInfoByProduct;
import com.project.vodto.kkb.ShippingInfoProduct;
import com.project.vodto.kkb.ShippingNoResponse;
import com.project.vodto.kkb.ShippingProductNoResponse;
import com.project.vodto.kkb.ShippingProductResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderDao;
	
	/* 배송 중 관리(조회) */
	@Override
	public Map<String, Object> getShippingInfo(OrderCondition shippingCond) {
		
		List<ShippingInfoByProduct> shippingOrderList = getShippingByProduct(shippingCond);
		List<ShippingProductNoResponse> shippingProductNoList = adminOrderDao.findShippingProductNoByInfo(shippingCond);
		List<ShippingProductResponse> shippingProductList = adminOrderDao.findShippingProductByInfo(shippingCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("shippingOrderList", shippingOrderList);
		result.put("shippingProductNoList", shippingProductNoList);
		result.put("shippingProductList", shippingProductList);
		
		return result;
	}

	/* 배송 준비중 관리(배송중 처리) */
	@Override
	public int editShipped(List<String> productNoList) {
		return adminOrderDao.changeShipped(productNoList);
	}

	/* 배송 준비중 관리(출고 완료 처리) */
	@Override
	public int editCompleteShipment(List<String> productNoList) {
		return adminOrderDao.changeCompleteShipment(productNoList);
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
	public Map<String, Object> getReadyInfo(OrderCondition readyCond) {
		
		List<ReadyInfoByProduct> readyOrderList = getReadyByProduct(readyCond);
		List<ReadyProductResponse> readyProductList = adminOrderDao.findReadyProductByInfo(readyCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("readyOrderList", readyOrderList);
		result.put("readyProductList", readyProductList);
		
		return result;
	}
	
	/* 입금 전 관리 (주문 취소 버튼 - 품목주문별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositProductCancel(List<DepositProductCancelRequest> productOrderNoList) {
		
		int result = -1;
		
		List<String> orderNoList = productOrderNoList.stream()
    			.collect(Collectors.groupingBy(DepositProductCancelRequest::getConvertedOrderNo))
	            .entrySet().stream()
	            .map(order -> order.getKey())
	            .collect(Collectors.toList());
		
		List<String> productNoList = productOrderNoList.stream()
				.map(DepositProductCancelRequest::getProductOrderNo)	
				.collect(Collectors.toList());
	
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changeDepositProductCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(돌려줄 쿠폰(count:0) 확인하기 위해 select) */
		List<CheckedCoupons> couponList = adminOrderDao.findDepositProductCancelCoupon(orderNoList);
		
		
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		adminOrderDao.changeDepositProductCancelCoupon(couponList); // 적용 쿠폰 수가 0일 때만 돌려줌
		
		
		/* 적립금 로그 테이블 update(column : reason, balance, reward) 
		 * 회원 테이블 update(column : total_rewards, accumulated_use_reward) */
		if(adminOrderDao.changeDepositProductCancelReward(productNoList) <= 0) {
			return result;
		}
		
		/* 포인트 로그 테이블 update(column : reason, balance, point) 
		 * 회원 테이블 update(column : total_points, accumulated_use_point) */
		if(adminOrderDao.changeDepositProductCancelPoint(productNoList) <= 0) {
			return result;
		}
		
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * 							accumulated_use_reward, accumulated_use_point ) */
		List<CanceledCoupons> canceledCoupons = CanceledCoupons.convert(couponList);
		if(adminOrderDao.changeDepositProductCancelMember(canceledCoupons) <= 0) {
			return result;
		}
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changeDepositProductCancel(productNoList) <= 0 ) {
			return result;
		}
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changeDepositProductCancelPayments(orderNoList) > 0) {
			List<DepositCancelInfoResponse> cancelInfoList = 
					adminOrderDao.findDepositProductCancelInfo(orderNoList);
			
			result = adminOrderDao.saveDepositOrderCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금 전 관리 (주문 취소 버튼 - 주문번호별) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositOrderCancel(List<String> orderNoList) {
		
		int result = -1;
		
		/* 주문 내역 테이블 update(column : delivery_status) */
		if(adminOrderDao.changeDepositOrderCancelHistory(orderNoList) <= 0) {
			return result;
		}
		
		/* 쿠폰 로그 테이블 update(column : used_date, related_order) */
		if(adminOrderDao.changeDepositOrderCancelCoupon(orderNoList) <= 0) {
			return result;
		}
		
		/* 적립금 로그 테이블 update(column : reason, balance, reward) */
		if(adminOrderDao.changeDepositOrderCancelReward(orderNoList) <= 0) {
			return result;
		}
		
		/* 포인트 로그 테이블 update(column : reason, balance, point) */
		if(adminOrderDao.changeDepositOrderCancelPoint(orderNoList) <= 0) {
			return result ;
		}
		
		/* 회원 테이블 update(column : total_points, total_rewards, coupon_count,
		 * 							accumulated_use_reward,accumulated_use_point ) */
		if(adminOrderDao.changeDepositOrderCancelMember(orderNoList) <= 0) {
			return result;
		}
		
		/* 주문 상세 상품 테이블 update(column : product_status, coupon_discount) */
		if(adminOrderDao.changeDepositOrderCancel(orderNoList) <= 0 ) {
			return result;
		}
		
		/* 결제 테이블 update(column : payment_status) */
		if(adminOrderDao.changeDepositOrderCancelPayments(orderNoList) > 0) {
			List<DepositCancelInfoResponse> cancelInfoList = 
					adminOrderDao.findDepositCancelInfo(orderNoList);
			
			result = adminOrderDao.saveDepositOrderCancel(cancelInfoList);
		}
		
		return result;
	}

	/* 입금전 관리 (입금 확인 버튼) */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editDepositConfirm(List<String> orderNoList) {
		
		int result = -1;
		
		/* 주문 상세 상품, 주문내역 테이블 상태 업데이트 */
		if(adminOrderDao.changeDepositConfirm(orderNoList) <= 0 ) {
			return result;
		}
		
		if(adminOrderDao.changeDepositConfirmHistory(orderNoList) > 0) {
			/* 주문 상세 상품 테이블에 송장 번호 입력일 업데이트 */
			result = adminOrderDao.changeDepositConfirmDate(orderNoList);
		}
		
		return result;
	}	
	
	/* 입금전 관리 (조회) */
	@Override
	public Map<String, Object> getDepositInfo(DepositCondition depositCond) {
		
		List<DepositNoResponse> depositOrderList = adminOrderDao.findDepositByInfo(depositCond);
		List<DepositByProduct> depositProductList = getDepositByProduct(depositCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("depositOrderList", depositOrderList);
		result.put("depositProductList", depositProductList);
		
		return result;
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
	
	private List<ShippingInfoByProduct> getShippingByProduct(OrderCondition shippingCond) {
		
		List<ShippingNoResponse> list = adminOrderDao.findShippingByInfo(shippingCond);

	    return list.stream()
	            .collect(Collectors.groupingBy(ShippingNoResponse::getOrderNo))
	            .entrySet().stream()
	            .map(order -> {
	                String orderNo = order.getKey();
	                List<ShippingInfoProduct> orders = order.getValue()
	                        .stream()
	                        .map(ShippingInfoProduct::from)
	                        .collect(Collectors.toList());

	                ShippingNoResponse info = order.getValue().get(0);

	                return new ShippingInfoByProduct(
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

	private List<DepositByProduct> getDepositByProduct(DepositCondition depositCond) {
		    
			List<DepositProductResponse> list = adminOrderDao.findDepositProductByInfo(depositCond);
	
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
	    
		List<ReadyNoResponse> list = adminOrderDao.findReadyByInfo(readyCond);

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

package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.DepositByProduct;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
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
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int editInvoiceNumber(List<InvoiceCondition> invoiceCondList) throws Exception {
		if(adminOrderRepository.changeInvoiceProduct(invoiceCondList) > 0) {
			
		}
		
		return 1;
	}
	
	@Override
	public Map<String, Object> getOrderInfo(OrderCondition orderCond) throws Exception {
		
		List<OrderNoResponse> orderList = adminOrderRepository.findOrderByInfo(orderCond);
		List<OrderByProduct> productList = getOrderByProduct(orderCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("orderNoList", orderList);
		result.put("productList", productList);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getDepositInfo(DepositCondition depositCond) throws Exception {
		
		List<DepositNoResponse> depositOrderList = adminOrderRepository.findDepositByInfo(depositCond);
		List<DepositByProduct> depositProductList = getDepositByProduct(depositCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("depositOrderList", depositOrderList);
		result.put("depositProductList", depositProductList);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getReadyInfo(OrderCondition readyCond) throws Exception {
		
		List<ReadyInfoByProduct> readyOrderList = getReadyByProduct(readyCond);
		List<ReadyProductResponse> readyProductList = adminOrderRepository.findReadyProductByInfo(readyCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("readyOrderList", readyOrderList);
		result.put("readyProductList", readyProductList);
		
		return result;
	}
	
		
	private List<OrderByProduct> getOrderByProduct(OrderCondition orderCond) throws Exception {
	    
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

	private List<DepositByProduct> getDepositByProduct(DepositCondition depositCond) throws Exception {
		    
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
	
	private List<ReadyInfoByProduct> getReadyByProduct(OrderCondition readyCond) throws Exception {
	    
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

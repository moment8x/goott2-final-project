package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.OrderByProduct;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProduct;
import com.project.vodto.kkb.OrderProductResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderRepository;

	@Override
	public Map<String, Object> getOrderInfo(OrderCondition orderCond) throws Exception {
		
		List<OrderNoResponse> orderList = adminOrderRepository.findOrderByInfo(orderCond);
		List<OrderByProduct> productList = getOrderByProductList(orderCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("orderNoList", orderList);
		result.put("productList", productList);
		
		return result;
	}
	
	public List<OrderByProduct> getOrderByProductList(OrderCondition orderCond) throws Exception {

		List<OrderProductResponse> list = adminOrderRepository.findProductByInfo(orderCond);
		
		return list.stream()
					.map(OrderProductResponse::getOrderNo)
					.distinct()
					.map(orderNo -> {
						List<OrderProduct> orders = list.stream()
								.filter(order -> order.getOrderNo().equals(orderNo))
								.map(OrderProduct::from)
								.collect(Collectors.toList());
						
						List<OrderProductResponse> duplicatedInfo = list.stream()
								.filter(item -> item.getOrderNo().equals(orderNo))
								.collect(Collectors.toList());
						
						OrderProductResponse info = duplicatedInfo.get(0);
				
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
								orders);
					})
					.collect(Collectors.toList());
		
		
	}

}

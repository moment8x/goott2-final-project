package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminOrderDAO;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService {
	
	private final AdminOrderDAO adminOrderRepository;

	@Override
	public Map<String, Object> getOrderInfo(OrderCondition orderCond) throws Exception {
		
		List<OrderNoResponse> orderList = adminOrderRepository.findOrderByInfo(orderCond);
		List<OrderProductResponse> productList = adminOrderRepository.findProductByInfo(orderCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("orderNoList", orderList);
		result.put("productList", productList);
		
		return result;
	}

}

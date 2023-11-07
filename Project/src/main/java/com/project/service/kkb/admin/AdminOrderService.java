package com.project.service.kkb.admin;

import java.util.Map;

public interface AdminOrderService {
	 
	// 전체 주문 조회
	Map<String, Object> getOrderInfo(String word) throws Exception;

}

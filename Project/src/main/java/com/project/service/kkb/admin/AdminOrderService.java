package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.OrderCondition;

public interface AdminOrderService {
	 
	/* 전체 주문 조회 */
	Map<String, Object> getOrderInfo(OrderCondition orderCond) throws Exception;

	/* 입금 전 관리 */
	Map<String, Object> getDepositInfo(DepositCondition depositCond) throws Exception;

}

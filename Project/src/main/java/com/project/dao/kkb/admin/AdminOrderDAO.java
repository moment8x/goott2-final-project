package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;

public interface AdminOrderDAO {
	
	/* 전체 주문 조회 (주문번호별) */
	List<OrderNoResponse> findOrderByInfo(OrderCondition order) throws Exception;
	
	/* 전체 주문 조회 (품목주문별) */
	List<OrderProductResponse> findProductByInfo(OrderCondition order) throws Exception;
	
}

package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;

public interface AdminOrderDAO {
	
	/* 전체 주문 조회 (주문번호별) */
	List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond) throws Exception;
	
	/* 전체 주문 조회 (품목주문별) */
	List<OrderProductResponse> findProductByInfo(OrderCondition orderCond) throws Exception;

	/* 입금 전 관리 (주문번호별) */
	List<DepositNoResponse> findDepositByInfo(DepositCondition depositCond) throws Exception;

	/* 입금 전 관리 (품목주문별) */
	List<DepositProductResponse> findDepositProductByInfo(DepositCondition depositCond) throws Exception;
	
}

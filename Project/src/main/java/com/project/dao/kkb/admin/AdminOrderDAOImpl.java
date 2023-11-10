package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminOrderDAOImpl implements AdminOrderDAO {
	
	private static String ns = "com.project.mappers.adminOrderMapper";
	private final SqlSession ses;

	@Override
	public List<OrderNoResponse> findOrderByInfo(OrderCondition order) throws Exception {
		
		return ses.selectList(ns + ".selectOrderNoInfo", order);
	}

	@Override
	public List<OrderProductResponse> findProductByInfo(OrderCondition order) throws Exception {
		
		return ses.selectList(ns + ".selectOrderProductInfo", order);
	}

}

package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.ReadyCondition;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminOrderDAOImpl implements AdminOrderDAO {
	
	private static String ns = "com.project.mappers.adminOrderMapper";
	private final SqlSession ses;

	@Override
	public List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond) throws Exception {
		return ses.selectList(ns + ".selectOrderNoInfo", orderCond);
	}

	@Override
	public List<OrderProductResponse> findProductByInfo(OrderCondition orderCond) throws Exception {
		return ses.selectList(ns + ".selectOrderProductInfo", orderCond);
	}

	@Override
	public List<DepositNoResponse> findDepositByInfo(DepositCondition depositCond) throws Exception {
		return ses.selectList(ns + ".selectDepositNoInfo", depositCond);
	}

	@Override
	public List<DepositProductResponse> findDepositProductByInfo(DepositCondition depositCond) throws Exception {
		return ses.selectList(ns + ".selectDepositProductInfo", depositCond);
	}

	@Override
	public List<ReadyNoResponse> findReadyByInfo(ReadyCondition readyCond) throws Exception {
		return ses.selectList(ns + ".selectReadyNoInfo", readyCond);
	}

	@Override
	public List<ReadyProductResponse> findReadyProductByInfo(ReadyCondition readyCond) throws Exception {
		return ses.selectList(ns + ".selectReadyProductInfo", readyCond);
	}

}

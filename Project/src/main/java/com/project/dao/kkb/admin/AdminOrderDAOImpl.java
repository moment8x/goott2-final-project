package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.DepositCancelInfoResponse;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
import com.project.vodto.kkb.DepositProductCancelRequest;
import com.project.vodto.kkb.DepositProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.ReadyNoResponse;
import com.project.vodto.kkb.ReadyProductResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminOrderDAOImpl implements AdminOrderDAO {
	
	private static String ns = "com.project.mappers.adminOrderMapper";
	private final SqlSession ses;

	@Override
	public List<OrderNoResponse> findOrderByInfo(OrderCondition orderCond) {
		return ses.selectList(ns + ".selectOrderNoInfo", orderCond);
	}

	@Override
	public List<OrderProductResponse> findProductByInfo(OrderCondition orderCond) {
		return ses.selectList(ns + ".selectOrderProductInfo", orderCond);
	}

	@Override
	public List<DepositNoResponse> findDepositByInfo(DepositCondition depositCond) {
		return ses.selectList(ns + ".selectDepositNoInfo", depositCond);
	}

	@Override
	public List<DepositProductResponse> findDepositProductByInfo(DepositCondition depositCond) {
		return ses.selectList(ns + ".selectDepositProductInfo", depositCond);
	}

	@Override
	public int changeDepositConfirm(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositConfirmNo", orderNoList);
	}

	@Override
	public int changeDepositConfirmDate(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositConfirmDate", orderNoList);
	}

	@Override
	public int changeDepositConfirmHistory(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositConfirmHistory", orderNoList);
	}

	@Override
	public int changeDepositOrderCancel(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancel", orderNoList);
	}

	@Override
	public int changeDepositOrderCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelHistory", orderNoList);
	}
	
	@Override
	public int changeDepositOrderCancelPayments(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelPayments", orderNoList);
	}
	
	@Override
	public int changeDepositOrderCancelCoupon(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelCoupon", orderNoList);
	}

	@Override
	public int changeDepositOrderCancelReward(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelReward", orderNoList);
	}

	@Override
	public int changeDepositOrderCancelPoint(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelPoint", orderNoList);
	}

	@Override
	public int changeDepositOrderCancelMember(List<String> orderNoList) {
		return ses.update(ns + ".updateDepositOrderCancelMember", orderNoList);
	}
	
	@Override
	public List<DepositCancelInfoResponse> findDepositCancelInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectDepositCancelInfo", orderNoList);
	}
	
	@Override
	public int saveDepositOrderCancel(List<DepositCancelInfoResponse> cancelInfoList) {
		return ses.insert(ns + ".insertDepositOrderCancel", cancelInfoList);
	}

	@Override
	public List<ReadyNoResponse> findReadyByInfo(OrderCondition readyCond) {
		return ses.selectList(ns + ".selectReadyNoInfo", readyCond);
	}

	@Override
	public List<ReadyProductResponse> findReadyProductByInfo(OrderCondition readyCond) {
		return ses.selectList(ns + ".selectReadyProductInfo", readyCond);
	}

	@Override
	public int changeInvoiceProduct(List<InvoiceCondition> invoiceCondList) {
		return ses.update(ns + ".updateInvoiceProduct", invoiceCondList);
	}

	@Override
	public int changeInvoiceHistory(InvoiceCondition invoiceCond) {
		return ses.update(ns + ".updateInvoiceHistory", invoiceCond);
	}

	@Override
	public int changeDepositProductCancel(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelHistory(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelPayments(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelCoupon(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelReward(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelPoint(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int changeDepositProductCancelMember(List<DepositProductCancelRequest> productOrderNoList) {
		// TODO Auto-generated method stub
		return 0;
	}
}

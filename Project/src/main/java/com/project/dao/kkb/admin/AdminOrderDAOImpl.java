package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.DepositCancelInfoResponse;
import com.project.vodto.kkb.DepositCondition;
import com.project.vodto.kkb.DepositNoResponse;
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
	public int changeDepositConfirm(List<String> orderNoList) throws Exception {
		return ses.update(ns + ".updateDepositConfirmNo", orderNoList);
	}

	@Override
	public int changeDepositConfirmDate(List<String> orderNoList) throws Exception {
		return ses.update(ns + ".updateDepositConfirmDate", orderNoList);
	}

	@Override
	public int changeDepositConfirmHistory(List<String> orderNoList) throws Exception {
		return ses.update(ns + ".updateDepositConfirmHistory", orderNoList);
	}

	@Override
	public int changeDepositOrderCancel(List<String> orderNoList) throws Exception {
		return ses.update(ns + ".updateDepositOrderCancel", orderNoList);
	}

	@Override
	public int changeDepositOrderCancelHistory(List<String> orderNoList) throws Exception {
		return ses.update(ns + ".updateDepositOrderCancelHistory", orderNoList);
	}

	@Override
	public List<DepositCancelInfoResponse> findDepositCancelInfo(List<String> orderNoList) throws Exception {
		return ses.selectList(ns + ".selectDepositCancelInfo", orderNoList);
	}
	
	@Override
	public int saveDepositOrderCancel(List<DepositCancelInfoResponse> cancelInfoList) throws Exception {
		return ses.insert(ns + ".insertDepositOrderCancel", cancelInfoList);
	}

	@Override
	public List<ReadyNoResponse> findReadyByInfo(OrderCondition readyCond) throws Exception {
		return ses.selectList(ns + ".selectReadyNoInfo", readyCond);
	}

	@Override
	public List<ReadyProductResponse> findReadyProductByInfo(OrderCondition readyCond) throws Exception {
		return ses.selectList(ns + ".selectReadyProductInfo", readyCond);
	}

	@Override
	public int changeInvoiceProduct(List<InvoiceCondition> invoiceCondList) throws Exception {
		return ses.update(ns + ".updateInvoiceProduct", invoiceCondList);
	}

	@Override
	public int changeInvoiceHistory(InvoiceCondition invoiceCond) throws Exception {
		return ses.update(ns + ".updateInvoiceHistory", invoiceCond);
	}
}

package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CancelResponse;
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.DeliveredNoResponse;
import com.project.vodto.kkb.DeliveredProductNoResponse;
import com.project.vodto.kkb.DeliveredProductResponse;
import com.project.vodto.kkb.InTransitNoResponse;
import com.project.vodto.kkb.InTransitProductNoResponse;
import com.project.vodto.kkb.InTransitProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCancelInfoResponse;
import com.project.vodto.kkb.PendingCancelResponse;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.PendingNoResponse;
import com.project.vodto.kkb.PendingProductResponse;
import com.project.vodto.kkb.PreparationNoResponse;
import com.project.vodto.kkb.PreparationProductResponse;

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
	public int changePendingPayment(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingPayment", orderNoList);
	}

	@Override
	public List<PendingNoResponse> findPendingByInfo(PendingCondition pendingCond) {
		return ses.selectList(ns + ".selectPendingNoInfo", pendingCond);
	}

	@Override
	public List<PendingProductResponse> findPendingProductByInfo(PendingCondition pendingCond) {
		return ses.selectList(ns + ".selectPendingProductInfo", pendingCond);
	}

	@Override
	public int changePreShipped(List<String> orderNoList) {
		return ses.update(ns + ".updatePreShipped", orderNoList);
	}

	@Override
	public int changePreShippedDate(List<String> orderNoList) {
		return ses.update(ns + ".updatePreShippedDate", orderNoList);
	}

	@Override
	public int changePendingProductCancel(List<String> productNoList) {
		return ses.update(ns + ".updatePendingProductCancel", productNoList);
	}

	@Override
	public int changePendingProductCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingProductCancelHistory", orderNoList);
	}

	@Override
	public int changePendingProductCancelPayments(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingProductCancelPayments", orderNoList);
	}
	
	@Override
	public List<CheckedCoupons> findPendingProductCancelCoupon(List<String> orderNoList) {
		return ses.selectList(ns + ".selectPendingProductCancelCoupon", orderNoList);
	}

	@Override
	public int changePendingProductCancelCoupon(List<CheckedCoupons> couponList) {
		return ses.update(ns + ".updatePendingProductCancelCoupon", couponList);
	}
	
	@Override
	public int changePendingProductCancelReward(List<String> productNoList) {
		return ses.update(ns + ".updatePendingProductCancelReward", productNoList);
	}

	@Override
	public int changePendingProductCancelPoint(List<String> productNoList) {
		return ses.update(ns + ".updatePendingProductCancelPoint", productNoList);
	}

	@Override
	public int changePendingProductCancelMember(List<CanceledCoupons> canceledCoupons) {
		return ses.update(ns + ".updatePendingProductCancelMember", canceledCoupons);
	}

	@Override
	public List<PendingCancelInfoResponse> findPendingProductCancelInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectPendingProductCancelInfo", orderNoList);
	}
	
	@Override
	public int changePendingOrderCancel(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancel", orderNoList);
	}

	@Override
	public int changePendingOrderCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelHistory", orderNoList);
	}
	
	@Override
	public int changePendingOrderCancelPayments(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelPayments", orderNoList);
	}
	
	@Override
	public int changePendingOrderCancelCoupon(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelCoupon", orderNoList);
	}

	@Override
	public int changePendingOrderCancelReward(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelReward", orderNoList);
	}

	@Override
	public int changePendingOrderCancelPoint(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelPoint", orderNoList);
	}

	@Override
	public int changePendingOrderCancelMember(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingOrderCancelMember", orderNoList);
	}
	
	@Override
	public List<PendingCancelInfoResponse> findPendingCancelInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectPendingCancelInfo", orderNoList);
	}
	
	@Override
	public int savePendingOrderCancel(List<PendingCancelInfoResponse> cancelInfoList) {
		return ses.insert(ns + ".insertPendingOrderCancel", cancelInfoList);
	}

	@Override
	public List<PreparationNoResponse> findPreparationByInfo(OrderCondition preparationCond) {
		return ses.selectList(ns + ".selectPreparationNoInfo", preparationCond);
	}

	@Override
	public List<PreparationProductResponse> findPreparationProductByInfo(OrderCondition preparationCond) {
		return ses.selectList(ns + ".selectPreparationProductInfo", preparationCond);
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
	public int changeShippedByNo(List<String> orderNoList) {
		return ses.update(ns + ".updateShippedByNo", orderNoList);
	}
	
	@Override
	public int changeShippedByProductNo(List<String> productNoList) {
		return ses.update(ns + ".updateShippedByProductNo", productNoList);
	}

	@Override
	public int changeInTransitByNo(List<String> orderNoList) {
		return ses.update(ns + ".updateInTransitByNo", orderNoList);
	}
	
	@Override
	public int changeInTransitByProductNo(List<String> productNoList) {
		return ses.update(ns + ".updateInTransitByProductNo", productNoList);
	}

	@Override
	public List<InTransitNoResponse> findInTransitByInfo(OrderCondition inTransitCond) {
		return ses.selectList(ns + ".selectInTransitNoInfo", inTransitCond);
	}

	@Override
	public List<InTransitProductResponse> findInTransitProductByInfo(OrderCondition inTransitCond) {
		return ses.selectList(ns + ".selectInTransitProductInfo", inTransitCond);
	}

	@Override
	public List<InTransitProductNoResponse> findInTransitProductNoByInfo(OrderCondition inTransitCond) {
		return ses.selectList(ns + ".selectInTransitProductNoInfo", inTransitCond);
	}
	
	@Override
	public int changeDeliveredByNo(List<String> orderNoList) {
		return ses.update(ns + ".updateDeliveredByNo", orderNoList);
	}

	@Override
	public int changeDeliveredByProductNo(List<String> productNoList) {
		return ses.update(ns + ".updateDeliveredByProductNo", productNoList);
	}

	@Override
	public List<DeliveredNoResponse> findDeliveredByInfo(OrderCondition deliveredCond) {
		return ses.selectList(ns + ".selectDeliveredByInfo", deliveredCond);
	}
	
	@Override
	public List<DeliveredProductNoResponse> findDeliveredProductNoByInfo(OrderCondition deliveredCond) {
		return ses.selectList(ns + ".selectDeliveredProductNoByInfo", deliveredCond);
	}
	
	@Override
	public List<DeliveredProductResponse> findDeliveredProductByInfo(OrderCondition deliveredCond) {
		return ses.selectList(ns + ".selectDeliveredProductByInfo", deliveredCond);
	}

	@Override
	public List<PendingCancelResponse> findPendingCancelByInfo(PendingCancelCondition pendingCancelCond) {
		return ses.selectList(ns + ".selectPendingCancelByInfo", pendingCancelCond);
	}

	@Override
	public List<CancelResponse> findCanceledProduct(CancelCondition cancelCond) {
		return ses.selectList(ns + ".selectCancelByInfo", cancelCond);
	}
}

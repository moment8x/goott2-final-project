package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.CancelCondition;
import com.project.vodto.kkb.CancelResponse;
import com.project.vodto.kkb.CanceledCoupons;
import com.project.vodto.kkb.CardCancelCondition;
import com.project.vodto.kkb.CardCancelResponse;
import com.project.vodto.kkb.CheckedCoupons;
import com.project.vodto.kkb.DeliveredNoResponse;
import com.project.vodto.kkb.DeliveredProductNoResponse;
import com.project.vodto.kkb.DeliveredProductResponse;
import com.project.vodto.kkb.ExchangeResponse;
import com.project.vodto.kkb.InTransitNoResponse;
import com.project.vodto.kkb.InTransitProductNoResponse;
import com.project.vodto.kkb.InTransitProductResponse;
import com.project.vodto.kkb.InvoiceCondition;
import com.project.vodto.kkb.OrderCondition;
import com.project.vodto.kkb.OrderNoResponse;
import com.project.vodto.kkb.OrderProductResponse;
import com.project.vodto.kkb.OrderStatus;
import com.project.vodto.kkb.PendingCancelCondition;
import com.project.vodto.kkb.PendingCancelInfoResponse;
import com.project.vodto.kkb.PendingCancelResponse;
import com.project.vodto.kkb.PendingCondition;
import com.project.vodto.kkb.PendingNoResponse;
import com.project.vodto.kkb.PendingProductResponse;
import com.project.vodto.kkb.PreparationNoResponse;
import com.project.vodto.kkb.PreparationProductResponse;
import com.project.vodto.kkb.ProductCancelRequest;
import com.project.vodto.kkb.RefundNoInfo;
import com.project.vodto.kkb.RefundProductInfo;
import com.project.vodto.kkb.RefundResponse;
import com.project.vodto.kkb.ReturnResponse;

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
	public int changePendingProductCancel(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updatePendingProductCancel", productOrderNoList);
	}

	@Override
	public int changePendingProductCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updatePendingProductCancelHistory", orderNoList);
	}

	@Override
	public int changePendingProductCancelPayments(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updatePendingProductCancelPayments", productOrderNoList);
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
	public int savePendingProductCancelReward(List<ProductCancelRequest> productOrderNoList) {
		return ses.insert(ns + ".insertPendingProductCancelReward", productOrderNoList);
	}
	
	@Override
	public int changePendingProductCancelReward(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updatePendingProductCancelReward", productOrderNoList);
	}
	
	@Override
	public int savePendingProductCancelPoint(List<ProductCancelRequest> productOrderNoList) {
		return ses.insert(ns + ".insertPendingProductCancelPoint", productOrderNoList);
	}

	@Override
	public int changePendingProductCancelPoint(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updatePendingProductCancelPoint", productOrderNoList);
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
	public int savePendingProductCancel(List<PendingCancelInfoResponse> cancelInfoList) {
		return ses.insert(ns + ".insertPendingProductCancel", cancelInfoList);
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
	public int savePendingOrderCancelReward(List<String> orderNoList) {
		return ses.insert(ns + ".insertPendingOrderCancelReward", orderNoList);
	}

	@Override
	public int savePendingOrderCancelPoint(List<String> orderNoList) {
		return ses.update(ns + ".insertPendingOrderCancelPoint", orderNoList);
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
		return ses.selectList(ns + ".selectDeliveredNoInfo", deliveredCond);
	}
	
	@Override
	public List<DeliveredProductNoResponse> findDeliveredProductNoByInfo(OrderCondition deliveredCond) {
		return ses.selectList(ns + ".selectDeliveredProductNoInfo", deliveredCond);
	}
	
	@Override
	public List<DeliveredProductResponse> findDeliveredProductByInfo(OrderCondition deliveredCond) {
		return ses.selectList(ns + ".selectDeliveredProductInfo", deliveredCond);
	}

	@Override
	public List<PendingCancelResponse> findPendingCancelByInfo(PendingCancelCondition pendingCancelCond) {
		return ses.selectList(ns + ".selectPendingCancelByInfo", pendingCancelCond);
	}

	@Override
	public List<CancelResponse> findCancelProduct(CancelCondition cancelCond) {
		return ses.selectList(ns + ".selectCancelByInfo", cancelCond);
	}
	
	@Override
	public List<OrderStatus> findOrdersStatus(List<ProductCancelRequest> productOrderNoList) {
		return ses.selectList(ns + ".selectOrdersStatus", productOrderNoList);
	}
	
	@Override
	public int changeProductCancel(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updateProductCancel", productOrderNoList);
	}

	@Override
	public int changeProductCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updateProductCancelHistory", orderNoList);
	}

	@Override
	public int changeProductCancelPayments(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updateProductCancelPayments", productOrderNoList);
	}
	
	@Override
	public List<CheckedCoupons> findProductCancelCoupon(List<String> orderNoList) {
		return ses.selectList(ns + ".selectProductCancelCoupon", orderNoList);
	}

	@Override
	public int changeProductCancelCoupon(List<CheckedCoupons> couponList) {
		return ses.update(ns + ".updateProductCancelCoupon", couponList);
	}
	
	@Override
	public int saveProductCancelReward(List<ProductCancelRequest> productOrderNoList) {
		return ses.insert(ns + ".insertProductCancelReward", productOrderNoList);
	}
	
	@Override
	public int changeProductCancelReward(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updateProductCancelReward", productOrderNoList);
	}

	@Override
	public int saveProductCancelPoint(List<ProductCancelRequest> productOrderNoList) {
		return ses.insert(ns + ".insertProductCancelPoint", productOrderNoList);
	}
	
	@Override
	public int changeProductCancelPoint(List<ProductCancelRequest> productOrderNoList) {
		return ses.update(ns + ".updateProductCancelPoint", productOrderNoList);
	}

	@Override
	public int changeProductCancelMember(List<CanceledCoupons> canceledCoupons) {
		return ses.update(ns + ".updateProductCancelMember", canceledCoupons);
	}

	@Override
	public List<PendingCancelInfoResponse> findProductCancelInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectProductCancelInfo", orderNoList);
	}
	@Override
	public int saveProductCancel(List<PendingCancelInfoResponse> cancelInfoList) {
		return ses.insert(ns + ".insertProductCancel", cancelInfoList);
	}

	@Override
	public List<ExchangeResponse> findExchangeProduct(CancelCondition exchangeCond) {
		return ses.selectList(ns + ".selectExchangeByInfo", exchangeCond);
	}

	@Override
	public List<ReturnResponse> findReturnProduct(CancelCondition returnCond) {
		return ses.selectList(ns + ".selectReturnByInfo", returnCond);
	}

	@Override
	public List<RefundResponse> findRefundProduct(CancelCondition refundCond) {
		return ses.selectList(ns + ".selectRefundByInfo", refundCond);
	}

	@Override
	public List<CardCancelResponse> findCardCancelProduct(CardCancelCondition cardCancelCond) {
		return ses.selectList(ns + ".selectCardCancelByInfo", cardCancelCond);
	}
	
	@Override
	public int saveOrderCancelReward(List<String> orderNoList) {
		return ses.insert(ns + ".insertOrderCancelReward", orderNoList);
	}

	@Override
	public int saveOrderCancelPoint(List<String> orderNoList) {
		return ses.insert(ns + ".insertOrderCancelPoint", orderNoList);
	}

	@Override
	public int changeOrderCancel(List<String> orderNoList) {
		return ses.update(ns + ".updateOrderCancel", orderNoList);
	}

	@Override
	public int changeOrderCancelHistory(List<String> orderNoList) {
		return ses.update(ns + ".updateOrderCancelHistory", orderNoList);
	}

	@Override
	public int changeOrderCancelCoupon(List<String> orderNoList) {
		return ses.update(ns + ".updateOrderCancelCoupon", orderNoList);
	}

	@Override
	public int changeOrderCancelMember(List<String> orderNoList) {
		return ses.update(ns + ".updateOrderCancelMember", orderNoList);
	}

	@Override
	public int changeOrderCancelPayments(List<String> orderNoList) {
		return ses.update(ns + ".updateOrderCancelPayments", orderNoList);
	}

	@Override
	public List<PendingCancelInfoResponse> findCancelInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectCancelInfo", orderNoList);
	}

	@Override
	public int saveOrderCancel(List<PendingCancelInfoResponse> cancelInfoList) {
		return ses.insert(ns + ".insertOrderCancel", cancelInfoList);
	}

	@Override
	public List<RefundNoInfo> findOrderRefundInfo(List<String> orderNoList) {
		return ses.selectList(ns + ".selectOrderRefundInfo", orderNoList);
	}

	@Override
	public int saveOrderCancelRefund(List<RefundNoInfo> refundInfoList) {
		return ses.insert(ns + ".insertOrderCancelRefund", refundInfoList);
	}

	@Override
	public List<RefundProductInfo> findProductRefundInfo(List<ProductCancelRequest> productOrderNoList) {
		return ses.selectList(ns + ".selectProductRefundInfo", productOrderNoList);
	}

	@Override
	public int saveProductCancelRefund(List<RefundProductInfo> refundInfoList) {
		return ses.insert(ns + ".insertProductCancelRefund", refundInfoList);
	}
}

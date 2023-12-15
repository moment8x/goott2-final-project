package com.project.dao.ksh.order;


import java.util.List;
import java.util.Map;

import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.CompleteOrder;
import com.project.vodto.ksh.CompleteOrderItem;
import com.project.vodto.ksh.OrderInfo;
import com.project.vodto.ksh.PaymentDTO;

public interface OrderDAO {
//	int insertNewOrder(NonOrderHistory noh) throws Exception;
	int insertNewPayment(PaymentDTO pd) throws Exception;

	int insertNewNonOrderHistory(NonOrderHistory noh) throws Exception;

	CompleteOrder getPaymentHistory(String orderNo) throws Exception;

	List<OrderInfo> getProductInfo(List<String> product_id) throws Exception;

	int saveBankTransfer(PaymentDTO pd) throws Exception;

	List<ShippingAddress> getShippingAddr(String memberId) throws Exception;

	List<CouponInfos> getCouponInfos(String memberId) throws Exception;

	List<CouponInfos> addCategoryKey(List<CouponInfos> couponInfos) throws Exception;

	List<CompleteOrderItem> getDetailOrderItem(String orderNo, List<String> productId) throws Exception;

	int insertNewOrderHistory(OrderHistory oh) throws Exception;

	int updateCouponLogs(PaymentDTO pd) throws Exception;

	int updatePointLogs(PaymentDTO pd) throws Exception;

	int updateRewardLogs(PaymentDTO pd) throws Exception;
	
	int updateProducts(List<DetailOrderItem> itemList) throws Exception;
	
	int updateMemberCoupon(PaymentDTO pd) throws Exception;
	
	int updateMemberPoints(PaymentDTO pd) throws Exception;
	
	int updateMemberRewards(PaymentDTO pd) throws Exception;

	Memberkjy getMemberInfo(String memberId) throws Exception;

	int updateMemberAcumPayment(int actualPaymentAmount, String memberId) throws Exception;

	List<String> getProductIds(String orderNo) throws Exception;

	int saveDetailItems(List<DetailOrderItem> itemList) throws Exception;

	int deleteShoppingCart(PaymentDTO pd, List<DetailOrderItem> itemList);
	
	
	
	
}

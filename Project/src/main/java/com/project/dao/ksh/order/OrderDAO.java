package com.project.dao.ksh.order;


import java.util.List;
import java.util.Map;

import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderInfo;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;

public interface OrderDAO {
//	int insertNewOrder(NonOrderHistory noh) throws Exception;
	int insertNewPayment(PaymentDTO pd) throws Exception;

	int saveDetailItems(List<DetailOrderItem> itemList) throws Exception;

	int insertNewOrderHistory(NonOrderHistory noh) throws Exception;

	Payment getPaymentHistory(String orderNo) throws Exception;

	List<OrderInfo> getProductInfo(List<String> product_id) throws Exception;

	int saveBankTransfer(PaymentDTO pd) throws Exception;

	List<ShippingAddress> getShippingAddr(String memberId) throws Exception;

	List<CouponInfos> getCouponInfos(String memberId) throws Exception;

	List<CouponInfos> addCategoryKey(List<CouponInfos> couponInfos) throws Exception;
	
	
}

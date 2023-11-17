package com.project.service.ksh.payment;

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
import com.project.vodto.ksh.OrderInfo;
import com.project.vodto.ksh.PaymentDTO;

public interface OrderService {
	// 비회원 주문 내역 저장
//	void saveNonOrderHistory(NonOrderHistory noh) throws Exception;
	// 회원 주문 내역 저장
	
	// 주문 상세 상품 저장
	
	// 결제 해야 할 금액과 실 결제 금액 일치하는지 비교
	boolean compareAmount(PaymentDTO pd, List<DetailOrderItem> itemList, Memberkjy memberInfo) throws Exception;
	
	// 결제 내역 저장
	boolean savePayment(PaymentDTO pd, List<DetailOrderItem> itemList, Memberkjy memberInfo) throws Exception;

	boolean saveNonOrderHistory(NonOrderHistory noh) throws Exception;

	//Map<String, Object> getOrderHistory() throws Exception;
	
	Map<String, Object>getPaymentDetail(OrderHistory oh, List<String> productId) throws Exception;
	
	Map<String, Object>getPaymentDetail(NonOrderHistory noh) throws Exception;

	List<OrderInfo> getProductInfo(List<String> product_id) throws Exception;

	List<ShippingAddress> getShippingAddress(String memberId) throws Exception;

	List<CouponInfos> getCouponInfos(String memberId) throws Exception;
	
	public boolean saveOrderHistory(OrderHistory oh) throws Exception;
	
	boolean updateDiscountMethod(PaymentDTO pd, List<DetailOrderItem> itemList) throws Exception;

	Memberkjy getMemberInfo(String memberId) throws Exception;


	

}

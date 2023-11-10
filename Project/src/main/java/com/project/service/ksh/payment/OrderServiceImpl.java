package com.project.service.ksh.payment;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mchange.v2.sql.filter.SynchronizedFilterDataSource;
import com.project.dao.ksh.order.OrderDAO;
import com.project.vodto.CompleteOrder;
import com.project.vodto.CouponInfos;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.OrderHistory;
import com.project.vodto.OrderInfo;
import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderDAO od;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean savePayment(PaymentDTO pd, List<DetailOrderItem> itemList) throws Exception {
		boolean result = false;
		
		if(pd.getPaymentMethod().equals("point")) {	// method set
			if(pd.getCardName() == null) {
				pd.setPaymentMethod("kakaoPay");
			} else {
				pd.setPaymentMethod("naverPay");
			}
		}

		// 무통장 입금
		if(pd.getPaymentNumber().contains("bkt")) {
			pd.setPaymentTime(new Timestamp(System.currentTimeMillis()));	// 결제 시간 null이어서 set
			if(od.insertNewPayment(pd)>0) { // 결제
				System.out.println("결제 테이블 저장");
				if(od.saveDetailItems(itemList)>0) { // 주문 상세
					System.out.println("주문 상세 테이블 저장");
					if(od.saveBankTransfer(pd)>0) {
						System.out.println("무통장 입금 테이블 저장");
						result = true;
					}
				}
			}
		} else { // 카드 및 간편결제
			if(compareAmount(pd)) {	// 검증
				if(od.insertNewPayment(pd)>0) { // 결제
					if(od.saveDetailItems(itemList)>0) { // 주문 상세
						System.out.println("주문 상세 테이블 저장");
						result = true;
					}
				}
			} else { // 검증 실패
				// 취소 필요
			}
		}
		return result;
	}

	@Override
	public boolean compareAmount(PaymentDTO pd) {
		boolean result = false;
		if(pd.getAmountToPay() == (pd.getActualPaymentAmount())) {
			System.out.println("결제 해야 할 금액과 실 결제 금액 일치 - 검증 완료");
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean saveNonOrderHistory(NonOrderHistory noh) throws Exception {
		boolean result = false;
	
		if(od.insertNewNonOrderHistory(noh)>0) {
			System.out.println("주문내역 테이블 저장 성공");
			
			result = true;
		}; // 1이 나오면 성공
		
		System.out.println("result 값 : " +result);
		return result;
	}

	@Override
	public Map<String, Object> getPaymentDetail(String orderNo) throws Exception {
		Map<String, Object> paymentDetail = new HashMap<String, Object>();
		// 결제 가져오기
		CompleteOrder completeOrder = od.getPaymentHistory(orderNo);
		if(completeOrder != null) {
			System.out.println(completeOrder.toString());
			//List<DetailOrderItem> itemDetail = od.getDetailOrderItem(orderNo);
			//System.out.println(itemDetail.toString());
		};
		return paymentDetail;
	}

	@Override
	public List<OrderInfo> getProductInfo(List<String> productId) throws Exception {
		List<OrderInfo> productInfos = od.getProductInfo(productId);
		return productInfos;
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) throws Exception {
		// 회원 배송 주소록 가져오기
		
		return od.getShippingAddr(memberId);
	}

	@Override
	public List<CouponInfos> getCouponInfos(String memberId) throws Exception {
		// CouponInfos와 List<String> categoryKey 가져오기
		
		List<CouponInfos> couponInfos = od.getCouponInfos(memberId);
		od.addCategoryKey(couponInfos);
		
		
		return couponInfos;
	}

	@Override
	public boolean saveOrderHistory(OrderHistory oh) throws Exception {
		boolean result = false;
		if(od.insertNewOrderHistory(oh)>0) {
			System.out.println("회원 주문내역 테이블 저장 성공");
			
			result = true;
		}; // 1이 나오면 성공
		return result;
	}

//	@Override
//	public Map<String, Object> getOrderHistory() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}

	

//	@Override
//	public void saveNonOrderHistory(NonOrderHistory noh) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

}

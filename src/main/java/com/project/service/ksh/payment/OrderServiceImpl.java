package com.project.service.ksh.payment;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mchange.v2.sql.filter.SynchronizedFilterDataSource;
import com.project.dao.ksh.order.OrderDAO;
import com.project.vodto.DetailOrderItem;
import com.project.vodto.NonOrderHistory;

import com.project.vodto.PaymentDTO;
import com.project.vodto.Product;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderDAO od;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean savePayment(PaymentDTO pd, List<DetailOrderItem> itemList) throws Exception {
		boolean result = false;
		
		if(pd.getPayment_method().equals("point")) {	// method set
			if(pd.getCard_name() == null) {
				pd.setPayment_method("kakaoPay");
			} else {
				pd.setPayment_method("naverPay");
			}
		}

		// 무통장 입금
		if(pd.getPayment_number().contains("bkt")) {
			pd.setPayment_time(new Timestamp(System.currentTimeMillis()));	// 결제 시간 null이어서 set
			if(od.insertNewPayment(pd)>0) { // 결제
				System.out.println("결제 테이블 저장");
				if(od.saveDetailItems(itemList)>0) { // 주문 상세
					System.out.println("주문 상세 테이블 저장");
					result = true;
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
		if(pd.getAmount_to_pay() == (pd.getActual_payment_amount())) {
			System.out.println("결제 해야 할 금액과 실 결제 금액 일치 - 검증 완료");
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean saveOrderHistory(NonOrderHistory noh) throws Exception {
		boolean result = false;
		System.out.println("저장전?");
		if(od.insertNewOrderHistory(noh)>0) {
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
		od.getPaymentHistory(orderNo);
		return paymentDetail;
	}

	@Override
	public List<Product> getProductInfo(String[] product_id) {
		boolean result = false;
		List<Product> productInfos = od.getProductInfo(product_id);
		return productInfos;
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

package com.project.service.ksh.payment;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.persistence.ksh.OrderDAO;
import com.project.vodto.NonOrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	OrderDAO od;

	@Override
	public void savePayment(PaymentDTO pd) throws Exception {
		if (pd.getPayment_method().equals("point")) {
			pd.setPayment_method("kakaoPay");
		}
		System.out.println("DB에 저장되기 전 DTO 시간" + pd.getPayment_time().toString());
		
		od.insertNewPayment(pd);

	}

	@Override
	public boolean compareAmount(PaymentDTO pd) {
		boolean result = false;
		if(pd.getAmount_to_pay().equals(pd.getActual_payment_amount())) {
			System.out.println("결제 해야 할 금액과 실 결제 금액 일치 - 검증 완료");
			result = true;
		}
		
		return result;
	}

//	@Override
//	public void saveNonOrderHistory(NonOrderHistory noh) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

}

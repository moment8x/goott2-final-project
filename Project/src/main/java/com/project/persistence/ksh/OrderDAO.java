package com.project.persistence.ksh;


import com.project.vodto.NonOrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;

public interface OrderDAO {
//	int insertNewOrder(NonOrderHistory noh) throws Exception;
	int insertNewPayment(PaymentDTO pd) throws Exception;
}

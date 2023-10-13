package com.project.persistence.ksh;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


import com.project.vodto.NonOrderHistory;
import com.project.vodto.Payment;
import com.project.vodto.PaymentDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Inject
	private SqlSession ses; // db랑 연결해줌
	
	private static String ns = "com.ksh.mappers.KshMapper";
	
	@Override
	public int insertNewPayment(PaymentDTO pd) throws Exception {
	
		return ses.insert(ns + ".insertNewPayment", pd);
	}

//	@Override
//	public int insertNewOrder(NonOrderHistory noh) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}
	
	
}

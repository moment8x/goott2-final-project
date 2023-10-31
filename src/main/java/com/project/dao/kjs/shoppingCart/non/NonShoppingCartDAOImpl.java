package com.project.dao.kjs.shoppingCart.non;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.NonShoppingCart;

@Repository
public class NonShoppingCartDAOImpl implements NonShoppingCartDAO {
	@Inject
	SqlSession session;
	
	private String ns = "com.project.mappers.nonShoppingCartMapper";
	
	@Override
	public int insertNonMember(NonShoppingCart nsc) throws SQLException, NamingException {
		System.out.println("비회원 장바구니 dao단 - 비회원 정보 insert");
		
		return session.insert(ns + ".insertNonMember", nsc);
	}
}
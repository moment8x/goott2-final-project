package com.project.dao.kjs.shoppingCart.non;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.NonShoppingCart;

public interface NonShoppingCartDAO {
	// 비회원 쿠키 저장
	int insertNonMember(NonShoppingCart nsc) throws SQLException, NamingException;
	// 비회원 삭제
	int deleteNonMember() throws SQLException, NamingException;
}
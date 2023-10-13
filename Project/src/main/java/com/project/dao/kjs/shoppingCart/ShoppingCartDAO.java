package com.project.dao.kjs.shoppingCart;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.ShoppingCart;

public interface ShoppingCartDAO {
	// 비회원 장바구니 저장
	int insertShoppingCart(ShoppingCart sc) throws SQLException, NamingException;
	// 비회원 장바구니 조회
	List<ShoppingCart> selectShoppingCartNon(String nonMemberId) throws SQLException, NamingException;
	// 회원 장바구니 조회
	List<ShoppingCart> selectShoppingCart(String memberId) throws SQLException, NamingException;
	// 비회원 장바구니 삭제
	int deleteItem(String nonMemberId, String productId) throws SQLException, NamingException;
}
package com.project.service.kjs.shoppingcart;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import com.project.vodto.ShoppingCart;

public interface ShoppingCartService {
	// 장바구니 조회
	Map<String, Object> getShoppingCart(String memberId, boolean loginCheck) throws SQLException, NamingException;
	// 장바구니 삭제(1개)
	boolean deleteItem(String memberId, boolean loginCheck, String productId) throws SQLException, NamingException;
}
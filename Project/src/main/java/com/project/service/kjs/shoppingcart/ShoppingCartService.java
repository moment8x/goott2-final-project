package com.project.service.kjs.shoppingcart;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import com.project.vodto.kjs.ShowCartDTO;

public interface ShoppingCartService {
	// 장바구니 조회
	Map<String, Object> getShoppingCart(String memberId, boolean loginCheck) throws SQLException, NamingException;
	// 장바구니 삭제(1개)
	boolean deleteItem(String memberId, boolean loginCheck, String productId) throws SQLException, NamingException;
	// 선택된 장바구니 아이템 삭제
	boolean deleteItems(String memberId, boolean loginCheck, List<String> items) throws SQLException, NamingException;
	// 장바구니 추가
	boolean insertItem(String memberId, boolean loginCheck, String productId, int quantity) throws SQLException, NamingException;
	// 헤더 장바구니 정보 조회
	List<ShowCartDTO> getCartList(String memberId, boolean loginCheck) throws SQLException, NamingException;
	// 장바구니 수량 조회
	int countList(String memberId, boolean loginCheck) throws SQLException, NamingException;
	// 장바구니 수량 변경
	int updateQTY(String memberId, boolean loginCheck, String productId, int quantity) throws SQLException, NamingException;
}
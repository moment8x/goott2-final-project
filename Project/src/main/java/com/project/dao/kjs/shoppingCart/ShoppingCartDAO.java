package com.project.dao.kjs.shoppingCart;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.ShoppingCart;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ShowCartDTO;

public interface ShoppingCartDAO {
	// 비회원 장바구니 조회
	List<ShoppingCart> selectShoppingCartNon(String nonMemberId) throws SQLException, NamingException;
	// 회원 장바구니 조회
	List<ShoppingCart> selectShoppingCart(String memberId) throws SQLException, NamingException;
	// 비회원 장바구니 삭제
	int deleteItemNon(String nonMemberId, String productId) throws SQLException, NamingException;
	// 비회원 장바구니 저장
	int insertShoppingCartNon(String nonMemberId, String productId, int quantity) throws SQLException, NamingException;
	// 회원 장바구니 저장
	int insertShoppingCart(String memberId, String productId, int quantity) throws SQLException, NamingException;
	// 회원 장바구니 삭제
	int deleteItem(String memberId, String productId) throws SQLException, NamingException;
	// 비회원 헤더 장바구니 조회
	List<ShowCartDTO> getNonMemberShoppingCart(String nonMemberId) throws SQLException, NamingException;
	// 회원 헤더 장바구니 조회
	List<ShowCartDTO> getMemberShoppingCart(String memberId) throws SQLException, NamingException;
	// 비회원 장바구니 수량 체크
	int countListNon(String nonMemberId) throws SQLException, NamingException;
	// 회원 장바구니 수량 체크
	int countList(String memberId) throws SQLException, NamingException;
	// 회원 장바구니 수량 수정
	int updateQTY(String memberId, String productId, int quantity) throws SQLException, NamingException;
	// 비회원 장바구니 수량 수정
	int updateQTYNon(String nonMemberId, String productId, int quantity) throws SQLException, NamingException;
	// 현 재고 조회
	int getCurrentQTY(String productId) throws SQLException, NamingException;
	// 물품 정보 조회
	DisPlayedProductDTO selectProduct(String productId, String memberId, boolean loginCheck) throws SQLException, NamingException;
}
package com.project.dao.kjs.shoppingCart;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ShoppingCart;
import com.project.vodto.kjs.ShowCartDTO;

@Repository
public class ShoppingCartDAOImpl implements ShoppingCartDAO {
	@Inject
	SqlSession session;
	
	private String ns = "com.project.mappers.shoppingCartMapper";
	
	@Override
	public List<ShoppingCart> selectShoppingCartNon(String nonMemberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 정보 조회");
		return session.selectList(ns + ".selectNonMemberShoppingCart", nonMemberId);
	}

	@Override
	public List<ShoppingCart> selectShoppingCart(String memberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 장바구니 정보 조회");
		return session.selectList(ns + ".selectMemberShoppingCart", memberId);
	}

	@Override
	public int deleteItemNon(String nonMemberId, String productId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 아이템 단일 삭제");
		Map<String, String> params = new HashMap<String, String>();
		params.put("nonMemberId", nonMemberId);
		params.put("productId", productId);
		
		return session.delete(ns + ".deleteNonMemberCartItem", params);
	}

	@Override
	public int insertShoppingCartNon(String nonMemberId, String productId, int quantity) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 아이템 추가");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("nonMemberId", nonMemberId);
		params.put("productId", productId);
		params.put("quantity", quantity);
		
		return session.insert(ns + ".insertShoppingCartNon", params);
	}

	@Override
	public int insertShoppingCart(String memberId, String productId, int quantity) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 장바구니 아이템 추가");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		params.put("quantity", quantity);
		
		return session.insert(ns + ".insertShoppingCart", params);
	}

	@Override
	public int deleteItem(String memberId, String productId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 장바구니 아이템 단일 삭제");
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		
		return session.delete(ns + ".deleteMemberCartItem", params);
	}

	@Override
	public List<ShowCartDTO> getNonMemberShoppingCart(String nonMemberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 헤더 장바구니 정보 조회");
		
		return session.selectList(ns + ".getNonMemberShoppingCart", nonMemberId);
	}

	@Override
	public List<ShowCartDTO> getMemberShoppingCart(String memberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 헤더 장바구니 정보 조회");
		
		return session.selectList(ns + ".getMemberShoppingCart", memberId);
	}

	@Override
	public int countListNon(String nonMemberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 수량 조회");
		return session.selectOne(ns + ".countListNon", nonMemberId);
	}

	@Override
	public int countList(String memberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 장바구니 수량 조회");
		return session.selectOne(ns + ".countList", memberId);
	}

	@Override
	public int updateQTY(String memberId, String productId, int quantity) throws SQLException, NamingException {
		System.out.println("======= 장바구니 DAO단 - 회원 상품 수량 변경 =======");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		params.put("quantity", quantity);
		
		return session.update(ns + ".updateQTY", params);
	}

	@Override
	public int updateQTYNon(String nonMemberId, String productId, int quantity) throws SQLException, NamingException {
		System.out.println("======= 장바구니 DAO단 - 비회원 상품 수량 변경 =======");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("nonMemberId", nonMemberId);
		params.put("productId", productId);
		params.put("quantity", quantity);
		
		return session.update(ns + ".updateQTYNon", params);
	}
}
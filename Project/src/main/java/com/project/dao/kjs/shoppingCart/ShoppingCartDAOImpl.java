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

/**
 * @author goott1
 * @packageName : com.project.dao.kjs.shoppingCart
 * @fileName : ShoppingCartDAOImpl.java
 * @date : 2023. 10. 13.
 * @description :
 */
@Repository
public class ShoppingCartDAOImpl implements ShoppingCartDAO {
	@Inject
	SqlSession session;
	
	private String ns = "com.project.mappers.shoppingCartMapper";
	
	/**
	 * @MethodName : selectShoppingCartNon
	 * @author : goott1
	 * @param nonMemberId
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 dao단 - 비회원 장바구니 정보 조회
	 * @date : 2023. 10. 13.
	 */
	@Override
	public List<ShoppingCart> selectShoppingCartNon(String nonMemberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 정보 조회");
		return session.selectList(ns + ".selectNonMemberShoppingCart", nonMemberId);
	}

	/**
	 * @MethodName : insertShoppingCart
	 * @author : goott1
	 * @param sc
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 dao단 - 비회원 장바구니 추가
	 * @date : 2023. 10. 13.
	 */
	@Override
	public int insertShoppingCart(ShoppingCart sc) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 추가");
		return session.insert(ns + ".insertNonMemberShoppingCart", sc);
	}

	/**
	 * @MethodName : selectShoppingCart
	 * @author : goott1
	 * @param memberId
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 dao단 - 회원 장바구니 정보 조회`
	 * @date : 2023. 10. 13.
	 */
	@Override
	public List<ShoppingCart> selectShoppingCart(String memberId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 회원 장바구니 정보 조회");
		return session.selectList(ns + ".selectMemberShoppingCart", memberId);
	}

	/**
	 * @MethodName : deleteItem
	 * @author : goott1
	 * @param nonMemberId
	 * @param productId
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 dao단 - 비회원 장바구니 아이템 단일 삭제
	 * @date : 2023. 10. 13.
	 */
	@Override
	public int deleteItem(String nonMemberId, String productId) throws SQLException, NamingException {
		System.out.println("장바구니 dao단 - 비회원 장바구니 아이템 단일 삭제");
		Map<String, String> params = new HashMap<String, String>();
		params.put("non_member_id", nonMemberId);
		params.put("product_id", productId);
		
		return session.delete(ns + ".deleteNonMemberCartItem", params);
	}
}
package com.project.service.kjs.shoppingcart;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.kjs.product.ProductDAO;
import com.project.dao.kjs.shoppingCart.ShoppingCartDAO;
import com.project.vodto.Product;
import com.project.vodto.ShoppingCart;

/**
 * @author goott1
 * @packageName : com.project.service.kjs.shoppingcart
 * @fileName : ShoppingCartServiceImpl.java
 * @date : 2023. 10. 13.
 * @description :
 */
@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {
	@Inject
	private ShoppingCartDAO scDao;
	@Inject
	private ProductDAO pDao;
	
	/**
	 * @MethodName : getShoppingCart
	 * @author : goott1
	 * @param memberId
	 * @param loginCheck
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 서비스단 - 장바구니 정보 조회
	 * @date : 2023. 10. 13.
	 */
	@Override
	public Map<String, Object> getShoppingCart(String memberId, boolean loginCheck) throws SQLException, NamingException {
		// 가져가야 할 데이터 : ShoppingCart객체 내용물! 참고로 여러 개! 리스트 필요
		System.out.println("======= 장바구니 서비스단 - 장바구니 정보 조회 =======");
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 해당 (비)회원의 장바구니 물품 내역
		List<ShoppingCart> list = null;
		if (loginCheck) {
			// 회원일 시
			list = scDao.selectShoppingCart(memberId);
		} else {
			// 비회원일 시
			list = scDao.selectShoppingCartNon(memberId);
		}
		// 물품 내역의 상품id로 상품 정보 조회
		List<Product> items = new ArrayList<Product>();
		// 저장
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getProductId());
			items.add(pDao.selectProduct(list.get(i).getProductId()));
		}
		
		result.put("list", list);
		result.put("items", items);
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		
		return result;
	}

	/**
	 * @MethodName : deleteItem
	 * @author : goott1
	 * @param memberId
	 * @param loginCheck
	 * @param productId
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 * @returnValue : 
	 * @description : 장바구니 서비스단 - 장바구니 단일 아이템 삭제
	 * @date : 2023. 10. 13.
	 */
	@Override
	public boolean deleteItem(String memberId, boolean loginCheck, String productId)
			throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 장바구니 단일 아이템 삭제 =======");
		boolean result = false;
		
		if (loginCheck) {
			// 회원일 시
		} else {
			// 비회원일 시
			int check = scDao.deleteItemNon(memberId, productId);
			if (check > 0)	{
				System.out.println("삭제된 row의 수 : " + check);
				result = true;
			} // else : error
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		
		return result;
	}

	@Override
	public boolean dellteItems(String memberId, boolean loginCheck, List<String> items)
			throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 장바구니 선택 아이템 삭제 =======");
		boolean result = false;
		
		if (loginCheck) {
			// 회원일 시
		} else {
			// 비회원일 시
			int check = 0;
			for (int i = 0; i < items.size(); i++) {
				check += scDao.deleteItemNon(memberId, items.get(i));
			}
			if (check > 0) {
				System.out.println("삭제된 row의 수 : " + check);
				result = true;
			}
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		
		return result;
	}

	@Override
	public boolean insertItem(String memberId, boolean loginCheck, String productId)
			throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 장바구니에 아이템 추가 =======");
		boolean result = false;
		
		if (loginCheck) {
			// 회원일 시
		} else {
			// 비회원일 시
			if (scDao.insertShoppingCartNon(memberId, productId) == 1) {
				System.out.println("아이템 추가 성공");
				result = true;
			}
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		return result;
	}
}
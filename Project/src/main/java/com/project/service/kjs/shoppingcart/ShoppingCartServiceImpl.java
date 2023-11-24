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
import com.project.vodto.ShoppingCart;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ShowCartDTO;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {
	@Inject
	private ShoppingCartDAO scDao;
	@Inject
	private ProductDAO pDao;
	
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
		List<DisPlayedProductDTO> items = new ArrayList<DisPlayedProductDTO>();
		// 저장
		for (int i = 0; i < list.size(); i++) {
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
			if (scDao.deleteItem(memberId, productId) == 1) {
				result = true;
			}
		} else {
			// 비회원일 시
			int check = scDao.deleteItemNon(memberId, productId);
			if (check > 0)	{
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
				result = true;
			}
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		
		return result;
	}

	@Override
	public boolean insertItem(String memberId, boolean loginCheck, String productId, int quantity)
			throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 장바구니에 아이템 추가 =======");
		boolean result = false;
		boolean isFirst = true;
		
		// 기존에 장바구니에 담긴 상품인지 확인
		List<ShoppingCart> list = null;
		if (loginCheck) {
			// 회원일 시
			list = scDao.selectShoppingCart(memberId);
		} else {
			// 비회원일 시
			list = scDao.selectShoppingCartNon(memberId);
		}
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getProductId().equals(productId)) {
				isFirst = false;
				break;
			}
		}
		
		// 담긴 상품이 아닐 시
		if (isFirst) {
			if (loginCheck) {
				// 회원일 시
				if (scDao.insertShoppingCart(memberId, productId, quantity) == 1) {
					result = true;
				}
			} else {
				// 비회원일 시
				if (scDao.insertShoppingCartNon(memberId, productId, quantity) == 1) {
					result = true;
				}
			}
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		return result;
	}

	@Override
	public List<ShowCartDTO> getCartList(String memberId, boolean loginCheck) throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 헤더 장바구니 정보 조회 =======");
		List<ShowCartDTO> result = null;
		
		if (loginCheck) {
			result = scDao.getMemberShoppingCart(memberId);
		} else {
			result = scDao.getNonMemberShoppingCart(memberId);
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		return result;
	}

	@Override
	public int countList(String memberId, boolean loginCheck) throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 헤더 장바구니 정보 조회 =======");
		int result = -1;
		
		if (loginCheck) {
			result = scDao.countList(memberId);
		} else {
			result = scDao.countListNon(memberId);
		}
		System.out.println("======= 장바구니 서비스단 끝 =======");
		return result;
	}

	@Override
	public int updateQTY(String memberId, boolean loginCheck, String productId, int quantity)
			throws SQLException, NamingException {
		System.out.println("======= 장바구니 서비스단 - 상품 수량 변경 =======");
		int result = -1;
		
		if (loginCheck) {
			result = scDao.updateQTY(memberId, productId, quantity);
		} else {
			result = scDao.updateQTYNon(memberId, productId, quantity);
		}
		
		System.out.println("======= 장바구니 서비스단 끝 =======");
		return result;
	}
}
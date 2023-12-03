package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminShoppingCartDAO;
import com.project.vodto.kkb.CartResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminShoppingCartServiceImpl implements AdminShoppingCartService {
	
	private final AdminShoppingCartDAO adminShoppingCartDao;

	@Override
	public Map<String, Object> getCartInfoById(String memberId) {
		
		List<CartResponse> cartList = adminShoppingCartDao.findCartInfoById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cartList", cartList);
				
		return result;
	}
	
	

}

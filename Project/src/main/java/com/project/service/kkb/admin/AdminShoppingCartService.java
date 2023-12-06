package com.project.service.kkb.admin;

import java.util.Map;

public interface AdminShoppingCartService {
	
	/* 장바구니 정보 */
	Map<String, Object> getCartInfoById(String memberId);
}

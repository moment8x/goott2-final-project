package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.CartResponse;

public interface AdminShoppingCartDAO {
	
	/* 장바구니 정보 */
	List<CartResponse> findCartInfoById(String memberId);
}

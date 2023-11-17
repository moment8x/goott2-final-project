package com.project.service.kym.admin;

import java.util.Map;

import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kym.ProductsKym;



public interface AdminProductService {
	// 전체 상품 조회
	Map<String, Object> getTotalProductCount() throws Exception;

	// 상품 정보 조회
	Map<String, Object> getProductInfo(ProductsKym productList);
}

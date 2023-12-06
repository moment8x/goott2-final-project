package com.project.service;

import java.util.Map;


public interface AdminProductsService {
	// ----------------------------- 김상희 -----------------------------
	Map<String, Object> getAllProductsCount();
	Map<String, Object> getAllProducts(String sellingProducts);
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// 상품 목록 조회
	   Map<String, Object> getProductsList();
	   // 총 상품 종류 개수
	   int getTotalProductsCount();
	   // 선택된 카테고리 하위 리스트 조회
	   Map<String, Object> getCategoryChild(String categoryKey);
	   // 검색 조건에 맞는 상품 리스트 조회
	   Map<String, Object> getSearchProductsList(String searchCategory, String searchKey, String categoryCode, boolean childCategory, String publicationDate);
	// ----------------------------------------------------------------

	
}
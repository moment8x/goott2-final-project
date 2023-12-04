package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.vodto.kjs.AdminProductsSearchVO;
import com.project.vodto.kjs.AdminUpdateStockVO;

public interface AdminProductsService {
	// ----------------------------- 김상희 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// 상품 목록 조회
	Map<String, Object> getStockList();
	// 총 상품 종류 개수
	int getTotalProductsCount();
	// 선택된 카테고리 하위 리스트 조회
	Map<String, Object> getCategoryChild(String categoryKey);
	// 검색 조건에 맞는 상품 리스트 조회
	Map<String, Object> getSearchStockList(AdminProductsSearchVO search);
	// 재고량 업데이트
	int updateStock(List<AdminUpdateStockVO> updateStock);
	// 품절 상품 조회
	Map<String, Object> getSoldOutProducts();
	// ----------------------------------------------------------------
}
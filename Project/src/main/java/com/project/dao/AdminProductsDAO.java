package com.project.dao;

import java.util.List;

import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.AdminProductsSearchVO;

public interface AdminProductsDAO {
	// ----------------------------- 김상희 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// 상품 목록 조회
	List<AdminStockListVO> getStockList();
	// 총 상품 종류의 개수
	int getTotalProductsCount();
	// 하위 카테고리 조회
	List<ProductCategory> getCategoryChild(String categoryKey);
	// 검색 조건에 맞는 상품 리스트 조회
	List<AdminStockListVO> getSearchStockList(AdminProductsSearchVO search);
	// 재고량 업데이트
	int updateStock(List<AdminUpdateStockVO> updateStock);
	// 품절 상품 조회
	List<AdminStockListVO> getSoldOutProducts();
	// ----------------------------------------------------------------
}
package com.project.dao;

import java.util.List;

import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminProductsListVO;
import com.project.vodto.ksh.AdminProductsList;

public interface AdminProductsDAO {
	// ----------------------------- 김상희 -----------------------------
	int getProductsOnSaleCount();
	List<AdminProductsList> getAllProducts(String sellingProducts);
	// ----------------------------- 김상희 -----------------------------
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	// ----------------------------- 김재용 -----------------------------
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// ----------------------------- 김진솔 -----------------------------
	   // 상품 목록 조회
	   List<AdminProductsListVO> getProductsList();
	   // 총 상품 종류의 개수
	   int getTotalProductsCount();
	   // 하위 카테고리 조회
	   List<ProductCategory> getCategoryChild(String categoryKey);
	   // ----------------------------------------------------------------
	// ----------------------------------------------------------------
	
}
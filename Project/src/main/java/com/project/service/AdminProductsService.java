package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjs.AdminProductsSearchVO;
import com.project.vodto.kjs.AdminUpdateStockVO;

public interface AdminProductsService {
	// ----------------------------- 김상희 -----------------------------
	Map<String, Object> getAllProductsCount();
	Map<String, Object> getAllProducts(AdminProductsSearchVO search);
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	// 전체 상품 정보와 이미지들 가져오기
		public List<Products> getProductsForAdmin() throws Exception;
	
	// 카테고리 정보 가져오기
		public List<Categories> getCategoriesForAdmin(String key) throws Exception;
	
	// 상품 정보 등록
		public boolean inputProductsForAdmin(Products products, List<UploadFiles> uploadFiles) throws Exception;
		
	// 상품 정보 수정
		public boolean changeProductsForAdmin(Products products) throws Exception;
		
	// productId로 상품이미지들 가져오기
		public List<ProductImage> getProductImagesForAdmin(String productId) throws Exception;
		
	// 상품 이미지 저장
		public boolean inputProductImagesForAdmin(String productId, List<UploadFiles> uploadFiles) throws Exception;
		
	// 상품 이미지 삭제
		public boolean removeProductImagesForAdmin(String productId, String newFileName) throws Exception;
	
	// 상품 정보 삭제
		public List<ProductImage> removeProductForAdmin(String productId) throws Exception;
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
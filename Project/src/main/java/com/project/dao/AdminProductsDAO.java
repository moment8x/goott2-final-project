package com.project.dao;

import java.util.List;

import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.AdminProductsSearchVO;
import java.net.ConnectException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjs.AdminProductsListVO;
import com.project.vodto.ksh.AdminProductsList;

public interface AdminProductsDAO {
	// ----------------------------- 김상희 -----------------------------
	int getProductsOnSaleCount();
	List<AdminProductsList> getAllProducts(AdminProductsSearchVO search);
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	// product 리스트, 이미지들 가져오기
		public List<Products> selectProductsForAdmin() throws Exception;
	
	// key로 카테고리 정보 가져오기
		public List<Categories> selectProductCategoriesForAdmin(String key) throws Exception;
	
	// 상품 등록
		public int insertProductsForAdmin(Products products) throws Exception;
	// 상품 이미지 등록
		public int insertPrdouctsImages(Products products,List<UploadFiles> uploadFiles)throws Exception;
		
	// 상품 정보 수정
		public boolean updateProductsForAdmin(Products products) throws Exception;
	
	// productId로 해당하는 상품 이미지 가져오기
		public List<ProductImage> selectProductImageForAdmin(String productId) throws Exception;
		
	// 상품 이미지 넣기
		public int insertProductImagesForAdmin(String productId, List<UploadFiles> uploadFiles) throws Exception;
		
	// 상품 이미지 삭제
		public int deleteProductImageForAdmin(String productId, String newFileName, List<ProductImage> images) throws Exception;
		
	// 상품 삭제
		public int deleteProductForAdmin(String productId) throws Exception;
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
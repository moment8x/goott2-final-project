package com.project.dao;

import java.net.ConnectException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;

public interface AdminProductsDAO {
	// ----------------------------- 김상희 -----------------------------
	
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
	
	// ----------------------------------------------------------------
}
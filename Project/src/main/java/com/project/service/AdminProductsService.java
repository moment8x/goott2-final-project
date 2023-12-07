package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.Products;

public interface AdminProductsService {
	// ----------------------------- 김상희 -----------------------------
	
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

	
	// ----------------------------------------------------------------
}
package com.project.service.kjy;

import java.util.List;
import java.util.Map;

import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;

public interface ListService {
	// 리스트 페이지 장르 목록 가져오기
	public List<ProductCategories> getProductCategory(String key) throws Exception;
	// 리스트 페이지 상품 가져오기
	public Map<String, Object> getProductForList(String Key, int page, String sortBy) throws Exception;
	// 키로 해당 카테고리의 정보 가져오기
	public ProductCategories getCategoryInfo(String key) throws Exception;
	// 베스트 셀러 목록 가져오기
	public List<Products> getProductsBsetSeller(String key) throws Exception;
	// 상품 하나의 정보를 id로 가져오기
	public Products getProductById(String id) throws Exception;
	// 검색하기
	public List<Products> searchProducts(String val) throws Exception;
}

package com.project.service.kjy;

import java.util.List;
import java.util.Map;

import com.project.vodto.Product;
import com.project.vodto.ProductCategory;

public interface ListService {
	// 리스트 페이지 장르 목록 가져오기
	public List<ProductCategory> getProductCategory(String key) throws Exception;
	// 리스트 페이지 상품 가져오기
	public Map<String, Object> getProductForList(String Key, int page) throws Exception;
	// 키로 해당 카테고리의 정보 가져오기
	public ProductCategory getCategoryInfo(String key) throws Exception;
}

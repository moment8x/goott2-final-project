package com.project.dao.kjr;

import java.util.List;

import com.project.vodto.PagingInfo;
import com.project.vodto.Product;
import com.project.vodto.ProductCategory;

public interface ListDao {
	// 카테고리 목록 가져오는 메서드
	public List<ProductCategory> selectProductCategories(String key) throws Exception;
	
	// 리스트 페이지 상품 가져오기
	public List<Product> selectProductForList(String key, PagingInfo pi) throws Exception;
	
	// 키로 해당 카테고리 정보 가져오기
	public ProductCategory selectProductCategory(String key) throws Exception;
	
	// 페이징을 위한 전체 상품 개수 구하기
	int selectProductCount(String key) throws Exception;
}

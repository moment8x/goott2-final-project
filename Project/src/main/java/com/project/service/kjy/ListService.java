package com.project.service.kjy;

import java.util.List;
import java.util.Map;

import com.project.vodto.PagingInfo;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjy.SearchVO;

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
	public Map<String, Object> searchProducts(String val, String sort, int page) throws Exception;
	// 검색한 상품의 카테고리와 개수 가져오기
	public List<SearchVO> searchProductsCateogries(String val) throws Exception;
	// 검색한 상품의 언어 정보 가져오기
	public List<Integer> searchProductslang(String val) throws Exception;
	// 검색한 상품 가져오기 (필터가 있을 때)
	public Map<String, Object> searchProductsWithFilter(String val, List<String> checkedList, List<String> checkedLang, String sort, int page) throws Exception;
}

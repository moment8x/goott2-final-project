package com.project.dao.kjr;

import java.util.List;

import com.project.vodto.PagingInfo;
import com.project.vodto.ProductCategory;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;

public interface ListDao {
	// 카테고리 목록 가져오는 메서드
	public List<ProductCategories> selectProductCategories(String key) throws Exception;
	
	// 리스트 페이지 상품 가져오기 (최신순 정렬)
	public List<Products> selectProductForListSortByNew(String key, PagingInfo pi, String sortBy) throws Exception;
	
	// 리스트 페이지 상품 가져오기 (가격순 정렬)
	public List<Products> selectProductForListSortByPrice(String Key, PagingInfo pagingInfo, String sortBy) throws Exception;
	
	// 리스트 페이지 상품 가져오기 (판매순 정렬)
	public List<Products> selectProductForListSortBySell(String Key, PagingInfo pagingInfo, String sortBy) throws Exception;
	
	// 키로 해당 카테고리 정보 가져오기
	public ProductCategories selectProductCategory(String key) throws Exception;
	
	// 페이징을 위한 전체 상품 개수 구하기
	public int selectProductCount(String key) throws Exception;
	
}

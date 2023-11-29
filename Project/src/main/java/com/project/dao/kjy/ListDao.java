package com.project.dao.kjy;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.project.vodto.PagingInfo;
import com.project.vodto.ProductCategory;
import com.project.vodto.Wishlist;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjy.ProductsForList;
import com.project.vodto.kjy.SearchVO;

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
	
	
	// id값으로 상품 하나의 정보 가져오기
	public Products selectProductById(String id) throws Exception;
	// 상품 검색
	public List<Products> selectProductsSearching(String val, String sort, PagingInfo paging) throws Exception;
	// 검색된 상품의 카테고리 정보 가져오기
	public List<SearchVO> selectProductsCategoryBySearch(String val) throws Exception;
	// 검색된 상품들의 키 가져오기
	public List<String> selectProductKeyBySearch(String val) throws Exception;
	// 검색된 상품 가져오기 (필터 적용)
	public List<Products> selectProductsWithFilter(String val, List<String> checkedList,  List<String> checkedLang, String sort, PagingInfo paging) throws Exception;
	// 검색된 상품 총 갯수 가져오기
	public int selectSearchProductCount(String val, List<String> checkedList, List<String> checkedLang) throws Exception;
	// (카테고리에 맞는) 베스트셀러 목록 가져오기 (key 가 없다면 null)
	public List<ProductsForList> selectBsetSeller(String key) throws Exception;
	// 최신 도서 가져오기
	public List<ProductsForList> selectNewProducts(String lang) throws Exception;
	// 많이 팔린 상품순
	public List<ProductsForList> selectProductOrderBySellings(String lang) throws Exception;
	// 카트에 많이 담긴 상품순
	public List<ProductsForList> selectProductOrderByCart() throws Exception;
	// 평점 순
	public List<ProductsForList> selectProductOrderByRating() throws Exception;

//--------------------------------------------------------민정---------------------------------------------------------
	//해당 상품 카테고리 키 가져오기
	public String selectProductCategoryKey(String productId);

	//찜하기
	public int insertlikeProduct(String memberId, String productId, String productCategoryKey);
	
	//찜목록에 있는 상품아이디 가져오기
	public Wishlist getProductId(String productId, String memberId) throws Exception;
	
	//찜목록 가져오기
	public List<Wishlist> selectWishiList(String memberId) throws Exception;
	
	//찜 삭제
	public int deleteWishlist(String productId, String memberId) throws Exception;
//---------------------------------------------------------민정 끝------------------------------------------------------ 

	



}

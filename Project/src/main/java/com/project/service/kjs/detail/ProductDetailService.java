package com.project.service.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.kjs.BestSellerVO;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjs.ProductRatingCountVO;
import com.project.vodto.kjs.RelatedProductDTO;

public interface ProductDetailService {
	// 이미지 제외 정보 조회
	DisPlayedProductDTO getProductInfo(String productId) throws SQLException, NamingException;
	// 이미지 정보 조회
	List<ProductImage> getProductImages(String productId) throws SQLException, NamingException;
	// 카테고리 조회
	List<String> getCategory(String categoryKey) throws SQLException, NamingException;
	// 베스트셀러 n개 조회
	List<BestSellerVO> getBestSeller() throws SQLException, NamingException;
	// 관련 도서 n개 조회
	List<RelatedProductDTO> getRelatedProduct(String productId, String publisher, String categoryKey) throws SQLException, NamingException;
	// 해당 상품 별점 별 인원수 조회
	List<ProductRatingCountVO> getProductRatingCount(String productId) throws SQLException, NamingException;
}
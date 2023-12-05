package com.project.dao.kjs.detail;

import javax.naming.NamingException;

import java.sql.SQLException;
import java.util.List;

import com.project.vodto.kjs.BestSellerVO;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;

public interface ProductDetailDAO {
	// 상품 정보 조회(이미지 제외)
	DisPlayedProductDTO selectProductInfo(String productId) throws SQLException, NamingException;
	// 상품 정보 조회(이미지만)
	List<ProductImage> selectProductImages(String productId) throws SQLException, NamingException;
	// 카테고리 조회
	List<String> selectProductCategory(String categoryKey) throws SQLException, NamingException;
	// 베스트셀러 n개 조회
	List<BestSellerVO> getBestSeller(int count) throws SQLException, NamingException;
}
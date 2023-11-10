package com.project.dao.kjs.detail;

import javax.naming.NamingException;

import java.sql.SQLException;
import java.util.List;

import com.project.vodto.Product;
import com.project.vodto.kjs.ProductImage;

public interface ProductDetailDAO {
	// 상품 정보 조회(이미지 제외)
	Product selectProductInfo(String productId) throws SQLException, NamingException;
	// 상품 정보 조회(이미지만)
	List<ProductImage> selectProductImages(String productId) throws SQLException, NamingException; 
}
package com.project.service.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.Product;
import com.project.vodto.kjs.ProductImage;

public interface ProductDetailService {
	Product getProductInfo(String productId) throws SQLException, NamingException;
	List<ProductImage> getProductImages(String productId) throws SQLException, NamingException;
}
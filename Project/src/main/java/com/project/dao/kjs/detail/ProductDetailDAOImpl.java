package com.project.dao.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Product;
import com.project.vodto.kjs.ProductImage;

@Repository
public class ProductDetailDAOImpl implements ProductDetailDAO {

	@Inject
	SqlSession ses;
	
	String ns = "com.project.mappers.productMapper";
	
	@Override
	public Product selectProductInfo(String productId) throws SQLException, NamingException {
		System.out.println("======= 상품 상세정보 DAO - 상품 상세정보 조회 =======");
		
		return ses.selectOne(ns + ".getProductInfo", productId);
	}

	@Override
	public List<ProductImage> selectProductImages(String productId) throws SQLException, NamingException {
		System.out.println("======= 상품 상세정보 DAO - 상품 이미지 조회 =======");
		
		return ses.selectList(ns + ".getProductImages", productId);
	}
}
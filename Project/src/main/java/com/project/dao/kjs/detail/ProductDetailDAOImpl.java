package com.project.dao.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;

@Repository
public class ProductDetailDAOImpl implements ProductDetailDAO {

	@Inject
	SqlSession ses;
	
	String ns = "com.project.mappers.productMapper";
	
	@Override
	public DisPlayedProductDTO selectProductInfo(String productId) throws SQLException, NamingException {
		return ses.selectOne(ns + ".getProductInfo", productId);
	}

	@Override
	public List<ProductImage> selectProductImages(String productId) throws SQLException, NamingException {
		return ses.selectList(ns + ".getProductImages", productId);
	}

	@Override
	public List<String> selectProductCategory(String categoryKey) throws SQLException, NamingException {
		return ses.selectList(ns + ".getProductCategory", categoryKey);
	}
}
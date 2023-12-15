package com.project.dao.kjs.product;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjs.DisPlayedProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	@Inject
	SqlSession session;
	
	String ns = "com.project.mappers.productMapper";
	
	
	@Override
	public DisPlayedProductDTO selectProduct(String productId) throws SQLException, NamingException {
		return session.selectOne(ns + ".selectProduct", productId);
	}
}
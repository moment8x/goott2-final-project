package com.project.dao.kjs.product;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.Product;

public interface ProductDAO {
	Product selectProduct(String productId) throws SQLException, NamingException;
}
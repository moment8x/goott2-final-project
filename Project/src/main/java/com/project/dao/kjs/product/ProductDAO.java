package com.project.dao.kjs.product;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.kjs.DisPlayedProductDTO;

public interface ProductDAO {
	DisPlayedProductDTO selectProduct(String productId) throws SQLException, NamingException;
}
package com.project.service.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.kjs.detail.ProductDetailDAO;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;

@Service
public class ProductDetailServiceImpl implements ProductDetailService {
	
	@Inject
	ProductDetailDAO pdDao;

	@Override
	public DisPlayedProductDTO getProductInfo(String productId) throws SQLException, NamingException {
		DisPlayedProductDTO result = pdDao.selectProductInfo(productId);
		
		return result;
	}

	@Override
	public List<ProductImage> getProductImages(String productId) throws SQLException, NamingException {
		List<ProductImage> result = pdDao.selectProductImages(productId);
		
		return result;
	}

	@Override
	public List<String> getCategory(String categoryKey) throws SQLException, NamingException {
		List<String> result = pdDao.selectProductCategory(categoryKey);
		
		return result;
	}
}
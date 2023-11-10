package com.project.service.kjs.detail;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.kjs.detail.ProductDetailDAO;
import com.project.vodto.Product;
import com.project.vodto.kjs.ProductImage;

@Service
public class ProductDetailServiceImpl implements ProductDetailService {
	
	@Inject
	ProductDetailDAO pdDao;

	@Override
	public Product getProductInfo(String productId) throws SQLException, NamingException {
		System.out.println("======= 상품 상세정보 서비스 - 상품 정보 조회 =======");
		
		Product result = pdDao.selectProductInfo(productId);
		
		System.out.println("======= 상품 상세정보 서비스 종료 =======");
		return result;
	}

	@Override
	public List<ProductImage> getProductImages(String productId) throws SQLException, NamingException {
		System.out.println("======= 상품 상세정보 서비스 - 상품 이미지 조회 =======");
		
		List<ProductImage> result = pdDao.selectProductImages(productId);
		
		System.out.println("======= 상품 상세정보 서비스 종료 =======");
		return result;
	}
}
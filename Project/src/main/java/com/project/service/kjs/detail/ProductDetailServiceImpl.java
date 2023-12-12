package com.project.service.kjs.detail;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.kjs.detail.ProductDetailDAO;
import com.project.vodto.kjs.BestSellerVO;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjs.ProductRatingCountVO;
import com.project.vodto.kjs.RelatedProductDTO;

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

	@Override
	public List<BestSellerVO> getBestSeller() throws SQLException, NamingException {
		// 조회할 개수
		int count = 4;
		List<BestSellerVO> result = new ArrayList<BestSellerVO>();
		
		result = pdDao.getBestSeller(count);
		
		return result;
	}

	@Override
	public List<RelatedProductDTO> getRelatedProduct(String productId, String publisher, String categoryKey)
			throws SQLException, NamingException {
		// 조회할 개수
		int count = 7;
		
		List<RelatedProductDTO> result = new ArrayList<RelatedProductDTO>();
		result = pdDao.getRelatedProduct(count, productId, categoryKey, publisher);
		
		// 표시할 제목 길이 조절
		int length = 8;
		for (RelatedProductDTO data : result) {
			if (data.getProductName().length() > length) {
				data.setProductName(data.getProductName().substring(0, length) + "⋯");
			}
		}
		
		return result;
	}

	@Override
	public List<ProductRatingCountVO> getProductRatingCount(String productId) throws SQLException, NamingException {
		List<ProductRatingCountVO> result = new ArrayList<ProductRatingCountVO>();
		result = pdDao.getProductRatingCount(productId);
		return result;
	}
}
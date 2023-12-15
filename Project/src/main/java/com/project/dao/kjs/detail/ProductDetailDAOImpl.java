package com.project.dao.kjs.detail;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjs.BestSellerVO;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjs.ProductRatingCountVO;
import com.project.vodto.kjs.RelatedProductDTO;

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

	@Override
	public List<BestSellerVO> getBestSeller(int count) throws SQLException, NamingException {
		return ses.selectList(ns + ".getBestSeller", count);
	}

	@Override
	public List<RelatedProductDTO> getRelatedProduct(int count, String productId, String categoryKey, String publisher)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("count", count);
		params.put("productId", productId);
		params.put("categoryKey", categoryKey);
		params.put("publisher", publisher);
		
		return ses.selectList(ns + ".getRelatedProduct", params);
	}

	@Override
	public List<ProductRatingCountVO> getProductRatingCount(String productId) throws SQLException, NamingException {
		return ses.selectList(ns + ".getProductRatingCount", productId);
	}
}
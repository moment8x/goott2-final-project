package com.project.dao.kjr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.PagingInfo;
import com.project.vodto.Product;
import com.project.vodto.ProductCategory;

@Repository
public class ListDaoImpl implements ListDao {

	@Inject
	private SqlSession ses;
	private String ns = "com.project.mappers.listMapper";
	
	@Override
	public List<ProductCategory> selectProductCategories(String key) throws Exception {
		
		return ses.selectList(ns+".selectProductCategories", key);
	}

	@Override
	public List<Product> selectProductForList(String key, PagingInfo pi) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", key);
		param.put("startRowIndex", pi.getStartRowIndex());
		param.put("viewProductPerPage", pi.getViewProductPerPage());

		return ses.selectList(ns+".selectProductForList", param);
	}

	@Override
	public ProductCategory selectProductCategory(String key) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".selectProductCategory", key);
	}

	@Override
	public int selectProductCount(String key) throws Exception {
		
		return ses.selectOne(ns+".selectProductCount", key);
	}
}

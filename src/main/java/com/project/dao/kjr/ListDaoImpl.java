package com.project.dao.kjr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.PagingInfo;
import com.project.vodto.ProductCategory;
import com.project.vodtokjy.Products;

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
	public List<Products> selectProductForListSortByNew(String key, PagingInfo pi, String sortBy) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", key);
		param.put("startRowIndex", pi.getStartRowIndex());
		param.put("viewProductPerPage", pi.getViewProductPerPage());
		param.put("sortBy", "publication_date desc");


		return ses.selectList(ns+".selectProductForList", param);
	}
	@Override
	public List<Products> selectProductForListSortByPrice(String key, PagingInfo pi, String sortBy) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", key);
		param.put("startRowIndex", pi.getStartRowIndex());
		param.put("viewProductPerPage", pi.getViewProductPerPage());
		if ("high".equals(sortBy)) {
			param.put("sortBy", "selling_price desc");
		} else if ("low".equals(sortBy)){
			param.put("sortBy", "selling_price");
		}

		return ses.selectList(ns+".selectProductForList", param);
	}
	
	@Override
	public List<Products> selectProductForListSortBySell(String key, PagingInfo pi, String sortBy) throws Exception {
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

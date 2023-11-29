package com.project.dao.kjr;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.PagingInfo;
import com.project.vodto.ProductCategory;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjy.ProductsForList;
import com.project.vodto.kjy.SearchVO;

@Repository
public class ListDaoImpl implements ListDao {

	@Inject
	private SqlSession ses;
	private String ns = "com.project.mappers.listMapper";
	
	@Override
	public List<ProductCategories> selectProductCategories(String key) throws Exception {
		
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
	public int selectProductCount(String key) throws Exception {
		
		return ses.selectOne(ns+".selectProductCount", key);
	}

	@Override
	public ProductCategories selectProductCategory(String key) throws Exception {
		
		return ses.selectOne(ns+".selectProductCategoriesOne", key);
	}

	@Override
	public List<Products> selectBsetSeller(String key) throws Exception {
		// TODO Auto-generated method stub
		List<Products> lst = null;
		if (key != null) {
			 lst = ses.selectList(ns+".selectBestSellerFromId", key);
		} else {
			 lst = ses.selectList(ns+".selectBestSeller");
		}
		return lst;
	}

	@Override
	public Products selectProductById(String id) throws Exception {
		
		return ses.selectOne(ns+".selectProductById", id);
	}

	@Override
	public List<Products> selectProductsSearching(String val, String sort, PagingInfo paging) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		String value = "%" + val + "%";
		params.put("value", value);
		params.put("startRowIndex", paging.getStartRowIndex());
		params.put("endRowIndex", paging.getViewProductPerPage());
		switch (sort) {
		case "aToz":
			params.put("sort", "p.product_name");
			break;
		case "low":
			params.put("sort", "p.selling_price");
			break;
		case "high":
			params.put("sort", "p.selling_price desc");
			break;
		case "pop":
			params.put("sort", "p.product_name");
			break;

		default:
			break;
		}
		
		List<Products> searchedProducts = ses.selectList(ns+".selectProductsSearching", params);
		System.out.println("검색된 상품 : " +searchedProducts);
		return searchedProducts; 
	}

	@Override
	public List<SearchVO> selectProductsCategoryBySearch(String val) throws Exception {
		String value = "%" + val + "%";
		List<SearchVO> search = ses.selectList(ns+".selectSearchProductsCategories", value);
		return search;
	}

	@Override
	public List<String> selectProductKeyBySearch(String val) throws Exception {
		
		return ses.selectList(ns+".selectSearchPrductsKey", val);
	}

	@Override
	public List<Products> selectProductsWithFilter(String val, List<String> checkedList,  List<String> checkedLang, String sort, PagingInfo paging) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("val", val);
		params.put("checkedList", checkedList);
		params.put("checkedLang", checkedLang);
		params.put("startRowIndex", paging.getStartRowIndex());
		params.put("endRowIndex", paging.getViewProductPerPage());
		switch (sort) {
		case "aToz":
			params.put("sort", "p.product_name");
			break;
		case "low":
			params.put("sort", "p.selling_price");
			break;
		case "high":
			params.put("sort", "p.selling_price desc");
			break;
		case "pop":
			params.put("sort", "p.product_name");
			break;

		default:
			break;
		}
		
		List<Products> lst = ses.selectList(ns+".selectProductsSearchingWithFilter", params);
		return lst;
	}

	@Override
	public int selectSearchProductCount(String val,List<String> checkedList, List<String> checkedLang) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("val", val);
		params.put("checkedList", checkedList);
		params.put("checkedLang", checkedLang);
		return ses.selectOne(ns+".selectSearchProductCount", params);
	}

	@Override
	public List<ProductsForList> selectNewProducts() throws Exception {
		
		return ses.selectList(ns+".selectNewPrducts");
	}

	@Override
	public List<ProductsForList> selectProductOrderBySellings() throws Exception {
		List<ProductsForList> lst = ses.selectList(ns+".selectProductsOrderBySellings");
		System.out.println("리스?트 : " + lst);
		return lst;
	}

	@Override
	public List<ProductsForList> selectProductOrderByCart() throws Exception {
		
		return ses.selectList(ns+".selectProductsOrderByCart");
	}

	@Override
	public List<ProductsForList> selectProductOrderByRating() throws Exception {
	
		return ses.selectList(ns+".selectProductsOrderByRating");
	}

	

}

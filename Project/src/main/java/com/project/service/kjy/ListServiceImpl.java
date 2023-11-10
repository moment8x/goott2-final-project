package com.project.service.kjy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kjr.ListDao;
import com.project.vodto.PagingInfo;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;

@Service
public class ListServiceImpl implements ListService {

	@Inject
	private ListDao lDao;
	
	// 리스트페이지 목록 가져오기
	@Override
	public List<ProductCategories> getProductCategory(String categoryKey) throws Exception {
		
		return lDao.selectProductCategories(categoryKey);
	}

	// 리스트페이지 상품 가져오기
	@Override
	public Map<String, Object> getProductForList(String categoryKey, int page, String sortBy) throws Exception {
		PagingInfo pagingInfo = getPagingInfo(categoryKey, page);
		List <Products> lst = null;
		switch (sortBy) {
		case "new": 
			lst = lDao.selectProductForListSortByNew(categoryKey, pagingInfo, sortBy);
			break;
		case "sell": 
			lst = lDao.selectProductForListSortBySell(categoryKey, pagingInfo, sortBy);
			break;
		case "high": 
			lst = lDao.selectProductForListSortByPrice(categoryKey, pagingInfo, sortBy);
			break;
		case "low": 
			lst = lDao.selectProductForListSortByPrice(categoryKey, pagingInfo, sortBy);
			break;
		}
		System.out.println("lst : " + lst);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list_product", lst);
		map.put("paging_info", pagingInfo);
		
		return map;
	}

	// 키로 해당 카테고리 정보 가져오기
	@Override
	public ProductCategories getCategoryInfo(String key) throws Exception {
		// TODO Auto-generated method stub
		return lDao.selectProductCategory(key);
	}

	private PagingInfo getPagingInfo(String key, int page) throws Exception {		
		// 전체 글의 개수
		int ProductCounts = lDao.selectProductCount(key);
		
		PagingInfo pagingInfo = new PagingInfo(ProductCounts, 12, page, 10);
		System.out.println(pagingInfo.getStartRowIndex() + "start");
		return pagingInfo;
	}

	@Override
	public List<Products> getProductsBsetSeller(String key) throws Exception {
		
		return lDao.selectBsetSeller(key);
	}

	@Override
	public Products getProductById(String id) throws Exception {
		// TODO Auto-generated method stub
		return lDao.selectProductById(id);
	}

	@Override
	public List<Products> searchProducts(String val) throws Exception {
		
		return lDao.selectProductsSearching(val);
	}

}

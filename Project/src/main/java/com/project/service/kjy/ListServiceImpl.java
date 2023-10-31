package com.project.service.kjy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kjr.ListDao;
import com.project.vodto.PagingInfo;
import com.project.vodto.ProductCategory;
import com.project.vodtokjy.Products;

@Service
public class ListServiceImpl implements ListService {

	@Inject
	private ListDao lDao;
	
	// 리스트페이지 목록 가져오기
	@Override
	public List<ProductCategory> getProductCategory(String key) throws Exception {
		
		return lDao.selectProductCategories(key);
	}

	// 리스트페이지 상품 가져오기
	@Override
	public Map<String, Object> getProductForList(String Key, int page, String sortBy) throws Exception {
		PagingInfo pagingInfo = getPagingInfo(Key, page);
		List <Products> lst = null;
		switch (sortBy) {
		case "new": 
			lst = lDao.selectProductForListSortByNew(Key, pagingInfo, sortBy);
			break;
		case "sell": 
			lst = lDao.selectProductForListSortBySell(Key, pagingInfo, sortBy);
			break;
		case "high": 
			lst = lDao.selectProductForListSortByPrice(Key, pagingInfo, sortBy);
			break;
		case "low": 
			lst = lDao.selectProductForListSortByPrice(Key, pagingInfo, sortBy);
			break;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list_product", lst);
		map.put("paging_info", pagingInfo);
		
		return map;
	}

	// 키로 해당 카테고리 정보 가져오기
	@Override
	public ProductCategory getCategoryInfo(String key) throws Exception {
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

}

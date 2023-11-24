package com.project.service.kjy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kjr.ListDao;
import com.project.vodto.PagingInfo;
import com.project.vodto.Product;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjy.SearchVO;

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
	public Map<String, Object> searchProducts(String val, String sort, int page) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PagingInfo pagingSearch = getSearchPagingInfo(val, page, null, null);
		List<Products> lst = lDao.selectProductsSearching(val, sort, pagingSearch);
		map.put("pList", lst);
		map.put("paging", pagingSearch);
		return map;
	}

	@Override
	public List<SearchVO> searchProductsCateogries(String val) throws Exception {	
		// 해당하는 상품의 카테고리 이름과 해당하는 만큼의 갯수 가져오기
		List<SearchVO> lst = lDao.selectProductsCategoryBySearch(val);
		
		return lst;
	}

	@Override
	public List<Integer> searchProductslang(String val) throws Exception {
		List<Integer> lst = new ArrayList<>();
		
		// 검색에 해당하는 상품들의 카테고리 키 정보 가져오기
		List<String> keyList = lDao.selectProductKeyBySearch(val);
		int kor = 0;
		int eng = 0;
		int jap = 0;
		for(String key : keyList) {
			String lang = key.substring(0, 3);
			switch (lang) {
			case "KOR":
				kor += 1;
				break;
			case "ENG":
				eng += 1;			
				break;
			case "JAP":
				jap += 1;
				break;

			default:
				break;
			}
		}
		lst.add(kor);
		lst.add(eng);
		lst.add(jap);
		return lst;
	}

	@Override
	public Map<String, Object> searchProductsWithFilter(String val, List<String> checkedList, List<String> checkedLang, String sort, int page) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PagingInfo paging = getSearchPagingInfo(val, page, checkedList, checkedLang);
		List<Products> lst = lDao.selectProductsWithFilter(val, checkedList, checkedLang, sort, paging);
		map.put("pList", lst);
		map.put("paging", paging);
		return map;
	}
	
	private PagingInfo getSearchPagingInfo(String val, int page, List<String> checkedList, List<String> checkedLang ) throws Exception {	
		// 전체 글의 개수
		int ProductCounts = lDao.selectSearchProductCount(val, checkedList, checkedLang);
		
		PagingInfo pagingInfo = new PagingInfo(ProductCounts, 10, page, 10);
		System.out.println(pagingInfo.getStartRowIndex() + "start");
		return pagingInfo;
	}

}

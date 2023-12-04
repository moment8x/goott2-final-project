package com.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.AdminProductsDAO;
import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.AdminProductsSearchVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminProductsServiceImpl implements AdminProductsService {
	
	private final AdminProductsDAO adminProductsRepository;
	
	// ----------------------------- 김상희 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	@Override
	public Map<String, Object> getStockList() {
		System.out.println("상품 목록 조회");
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminStockListVO> list = adminProductsRepository.getStockList();
		int total = adminProductsRepository.getTotalProductsCount();
		if (list != null) {
			result.put("list", list);
			result.put("total", total);
		}
		
		return result;
	}

	@Override
	public int getTotalProductsCount() {
		return adminProductsRepository.getTotalProductsCount();
	}

	@Override
	public Map<String, Object> getCategoryChild(String categoryKey) {
		System.out.println("하위 카테고리 조회");
		Map<String, Object> result = new HashMap<String, Object>();
		List<ProductCategory> list = adminProductsRepository.getCategoryChild(categoryKey);
		
		if (list != null) {
			result.put("categoryList", list);
		}
		
		return result;
	}

	@Override
	public Map<String, Object> getSearchStockList(AdminProductsSearchVO search) {
		System.out.println("검색 조건에 맞는 상품 리스트 조회 - service");
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminStockListVO> list = new ArrayList<AdminStockListVO>();
		
		list = adminProductsRepository.getSearchStockList(search);
		result.put("list", list);
		
		return result;
	}

	@Override
	public int updateStock(List<AdminUpdateStockVO> updateStock) {
		System.out.println("재고량 업데이트 - service");
		int updateCount = -1;
		updateCount = adminProductsRepository.updateStock(updateStock);
		System.out.println("update count : " + updateCount);
		
		return updateCount;
	}

	@Override
	public Map<String, Object> getSoldOutProducts() {
		System.out.println("품절 상품 조회");
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminStockListVO> list = adminProductsRepository.getSoldOutProducts();
		if (list != null) {
			result.put("list", list);
			System.out.println("list : " + list.toString());
		}
		return null;
	}
	// ----------------------------------------------------------------
}
package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.AdminProductsDAO;
import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminProductsListVO;
import com.project.vodto.ksh.AdminProductsList;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminProductsServiceImpl implements AdminProductsService {
	
	private final AdminProductsDAO adminProductsRepository;

	// ----------------------------- 김상희 -----------------------------
	@Override
	public Map<String, Object> getAllProductsCount() {
		Map<String, Object> result = new HashMap<>();
		int totalCount = adminProductsRepository.getTotalProductsCount();
		int productsOnSaleCount = adminProductsRepository.getProductsOnSaleCount();
		int outOfStockProductCount = totalCount - productsOnSaleCount;
		result.put("totalCount", totalCount);
		result.put("productsOnSaleCount", productsOnSaleCount);
		result.put("outOfStockProductCount", outOfStockProductCount);
		return result;
	}
	
	@Override
	public Map<String, Object> getAllProducts(String sellingProducts) {
		Map<String, Object> result = new HashMap<>();
		List<AdminProductsList> allProducts = adminProductsRepository.getAllProducts(sellingProducts);
		result.put("allProducts", allProducts);
		return result;
	}
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// ----------------------------- 김진솔 -----------------------------
	   @Override
	   public Map<String, Object> getProductsList() {
	      System.out.println("상품 목록 조회");
	      Map<String, Object> result = new HashMap<String, Object>();
	      List<AdminProductsListVO> list = adminProductsRepository.getProductsList();
	      
	      if (list != null) {
	         result.put("list", list);
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
	   public Map<String, Object> getSearchProductsList(String searchCategory, String searchKey, String categoryCode,
	         boolean childCategory, String publicationDate) {
	      System.out.println("검색 조건에 맞는 상품 리스트 조회");
	      Map<String, Object> result = new HashMap<String, Object>();
	      
	      
	      
	      return result;
	   }
	   // ----------------------------------------------------------------
	// ----------------------------------------------------------------
}
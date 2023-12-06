package com.project.controller.kkb.admin;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.AdminProductsService;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/products")
public class AdminProductsController {
	
	@Inject
	private AdminProductsService adminProductsService;
	
	// ----------------------------- 김상희 -----------------------------
	@GetMapping("/dashBoardMain")
	public Map<String, Object> getAllPrdoctsCount() {
		Map<String, Object> result = adminProductsService.getAllProductsCount();
		return result;
	}
	
	@GetMapping("/productManage")	// 모든 상품 조회(판매중인 상품은 쿼리스트링으로 받아서)
	public Map<String, Object> getAllPrducts(@RequestParam String sellingProducts) {
		
		Map<String, Object> result = adminProductsService.getAllProducts(sellingProducts);
		
		return result;
	}
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	
	// ----------------------------- 김진솔 -----------------------------
	   @GetMapping("/")
	   public Map<String, Object> mainListPage() {
	      System.out.println("상품 목록 조회");
	      return adminProductsService.getProductsList();
	   }
	   
	   @GetMapping("/search")
	   public Map<String, Object> searchProducts(
	         @RequestParam String searchCategory,
	         @RequestParam String searchKey,
	         @RequestParam String categoryCode,
	         @RequestParam boolean childCategory,
	         @RequestParam String publicationDate
	         ) {
	      System.out.println("검색");
	      
	      /*
	      검색 분류 - searchKey,   검색 분류의 값 - searchValue
	      상품 분류 - category_code,   하위 분류 포함 검색 - child_category   (boolean)
	      상품 등록일 - publication_date
	      
	      
	      Language,         언어
	      major category,      대분류
	      middle category,   중분류
	      minor category      소분류
	      */
	      
	      
	      
	      return null;
	   }
	   
	   @GetMapping("/category/{categoryKey}")
	   public Map<String, Object> selectedCategories(@RequestParam String categoryKey) {
	      System.out.println("카테고리 - 하위 카테고리 조회");
	      return adminProductsService.getCategoryChild(categoryKey);
	   }
	   // ----------------------------------------------------------------
	// ----------------------------------------------------------------
}
package com.project.controller.kkb.admin;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.AdminProductsService;
import com.project.vodto.kjs.AdminProductsSearchVO;
import com.project.vodto.kjs.AdminUpdateStockVO;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/products")
public class AdminProductsController {
	
	private final AdminProductsService adminProductsService;
	
	// ----------------------------- 김상희 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	@GetMapping("/")
	public Map<String, Object> mainListPage() {
		System.out.println("상품 목록 조회");
		return adminProductsService.getStockList();
	}
	
	@GetMapping("/category/{categoryKey}")
	public Map<String, Object> selectedCategories(@RequestParam String categoryCode) {
		System.out.println("카테고리 - 하위 카테고리 조회");
		return adminProductsService.getCategoryChild(categoryCode);
	}
	
	@GetMapping("/search")
	public Map<String, Object> searchProducts(
			@RequestParam String searchKey,
			@RequestParam String searchValue,
			@RequestParam String categoryKey,
			@RequestParam(defaultValue = "0") byte childCategory,
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam(defaultValue = "2") byte bestSellerStatus
			) {
		System.out.println("검색 - controller");
		/*
		검색 분류 - searchKey,	검색 분류의 값 - searchValue
		상품 분류 - category_code,	하위 분류 포함 검색 - child_category	(boolean)
		상품 등록일 - start_date, end_date
		
		
		Language,			언어
		major category,		대분류
		middle category,	중분류
		minor category		소분류
		*/
		AdminProductsSearchVO search = AdminProductsSearchVO.create(searchKey, searchValue, categoryKey, childCategory, startDate, endDate, bestSellerStatus);
		return adminProductsService.getSearchStockList(search);
	}
	
	@PutMapping("/updateStock")
	public ResponseEntity<String> updateStock(@RequestBody List<AdminUpdateStockVO> updateStock) {
		System.out.println("재고량 변경 - controller");
		ResponseEntity<String> result = null;
		
		int i = adminProductsService.updateStock(updateStock);
		
		if (i > -1) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	@GetMapping("/soldout")
	public Map<String, Object> soldOutProducts() {
		System.out.println("품절 상품 조회");
		return adminProductsService.getSoldOutProducts();
	}
	// ----------------------------------------------------------------
}
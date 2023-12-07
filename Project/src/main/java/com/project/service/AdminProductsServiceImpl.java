package com.project.service;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.cj.xdevapi.Result;
import com.project.dao.AdminProductsDAO;
import com.project.service.kjs.upload.UploadFileService;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.Products;

import java.util.HashMap;
import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.AdminProductsSearchVO;
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
	
	@Override
	public List<Products> getProductsForAdmin() throws Exception {
		List<Products> lst = adminProductsDAO.selectProductsForAdmin();
		return lst;
	}

	@Override
	public List<Categories> getCategoriesForAdmin(String key) throws Exception {
		List<Categories> cateogries = adminProductsDAO.selectProductCategoriesForAdmin(key);
		return cateogries;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean inputProductsForAdmin(Products products, List<UploadFiles> uploadFiles) throws Exception {
		boolean result = false;
		if(adminProductsDAO.insertProductsForAdmin(products) == 1) {
			if(adminProductsDAO.insertPrdouctsImages(products, uploadFiles) == 1) {
				result = true;
			}
		}
		return result;
	}

	@Override
	public boolean changeProductsForAdmin(Products products) throws Exception {
		boolean result = false;
		if(adminProductsDAO.updateProductsForAdmin(products)) {
			result = true;
		}
		return result;
	}
	
	@Override
	public List<ProductImage> getProductImagesForAdmin(String productId) throws Exception {
		List<ProductImage> images = adminProductsDAO.selectProductImageForAdmin(productId);
		return images;
	}
	
	@Override
	public boolean inputProductImagesForAdmin(String productId, List<UploadFiles> fileList) throws Exception {
		boolean result = false;
		if(adminProductsDAO.insertProductImagesForAdmin(productId, fileList) == 1) {
			result = true;
		}
		return false;
	}
	@Override
	public boolean removeProductImagesForAdmin(String productId, String newFileName) throws Exception {
		boolean result = false;
		if(adminProductsDAO.deleteProductImageForAdmin(productId, newFileName, null) == 1) {
			result = true;
		}
		return result;
	}
	@Transactional(rollbackFor = Exception.class)
	@Override
	public List<ProductImage> removeProductForAdmin(String productId) throws Exception {
		// 먼저 이미지 정보 가져오기
		List<ProductImage> images = adminProductsDAO.selectProductImageForAdmin(productId);
		// 해당 이미지 삭제하기
		if(adminProductsDAO.deleteProductImageForAdmin(productId, null, images) == 1) {
			if(adminProductsDAO.deleteProductForAdmin(productId) == 1) {
				return images;
			}
		}
		return null;
	}
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
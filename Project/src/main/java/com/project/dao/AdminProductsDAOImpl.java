package com.project.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ProductCategory;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.AdminProductsSearchVO;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.Products;
import com.project.vodto.ksh.AdminProductsList;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminProductsDAOImpl implements AdminProductsDAO {
	
	private static String ns = "com.project.mappers.adminProductsMapper";
	private final SqlSession ses;
	
	// ----------------------------- 김상희 -----------------------------
	
	@Override
	public int getProductsOnSaleCount() {
		// 판매 중인 상품 개수
		return ses.selectOne(ns+".getProductsOnSaleCount");
	}
	
	@Override
	public List<AdminProductsList> getAllProducts(AdminProductsSearchVO search) {
		return ses.selectList(ns+".getAllProducts", search);
	}
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	@Override
	public List<Products> selectProductsForAdmin() throws Exception {
		List<Products> productsList = ses.selectList(ns+".selectProductInfoForAdmin");
		return productsList;
	}
	
	@Override
	public List<Categories> selectProductCategoriesForAdmin(String key) throws Exception {
		List<Categories> categories = ses.selectList(ns+".selectProductCategoriesForAdmin", key);
		return categories;
	}

	@Override
	public int insertProductsForAdmin(Products products) throws Exception {
		int result = ses.insert(ns+".insertProductsForAdmin", products);
		return result;
	} 
	
	@Override
	public int insertPrdouctsImages(Products products, List<UploadFiles> uploadFiles) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productsId", products.getProductId());
		params.put("uploadFiles", uploadFiles);
		int result = ses.insert(ns+".insertProductImagesForAdmin", params);
		return result;
	}
	
	@Override
	public boolean updateProductsForAdmin(Products products) throws Exception {
		boolean result = false;
		if(ses.update(ns+".updateProductProductForAdmin", products) == 1) {
			result = true;
		}
		return result;
	}
	

	@Override
	public List<ProductImage> selectProductImageForAdmin(String productId) throws Exception {
		List<ProductImage> images = ses.selectList(ns+".selectProductImageForAdmin", productId);
		return images;
	}
	
	@Override
	public int insertProductImagesForAdmin(String productId, List<UploadFiles> fileList) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("fileList", fileList);
		int result = ses.insert(ns+".insertProductImagesForAdmin", params);
		return result;
	}
	@Override
	public int deleteProductImageForAdmin(String productId, String newFileName, List<ProductImage> images) throws Exception {
		System.out.println(newFileName);
		if(images == null) {
			return ses.delete(ns+".deleteProductImageForAdmin", newFileName);
		}
		
		return ses.delete(ns+".deleteProductImagesForAdmin", images);
	}
	
	@Override
	public int deleteProductForAdmin(String productId) throws Exception {
			
		return ses.delete(ns+".deleteProductForAdmin", productId);
	}
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	@Override
	public List<AdminStockListVO> getStockList() {
		return ses.selectList(ns + ".getSearchProductsList");
	}

	@Override
	public int getTotalProductsCount() {
		return ses.selectOne(ns + ".totalProductsCount");
	}

	@Override
	public List<ProductCategory> getCategoryChild(String categoryKey) {
		return ses.selectList(ns + ".getCategoryChild", categoryKey);
	}

	@Override
	public List<AdminStockListVO> getSearchStockList(AdminProductsSearchVO search) {
		return ses.selectList(ns + ".getSearchProductsList", search);
	}

	@Override
	public int updateStock(List<AdminUpdateStockVO> updateStock) {
		return ses.update(ns + ".updateStock", updateStock);
	}

	@Override
	public List<AdminStockListVO> getSoldOutProducts() {
		return ses.selectList(ns + ".getSoldOutProducts");
	}
	// ----------------------------------------------------------------
}
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

@Service
public class AdminProductsServiceImpl implements AdminProductsService {
	
	@Inject
	private AdminProductsDAO adminProductsDAO;

	
	// ----------------------------- 김상희 -----------------------------
	
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
	// ----------------------------------------------------------------



}
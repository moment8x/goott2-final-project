package com.project.dao.kjy;

import java.util.List;

import com.project.vodto.kjy.Products;

public interface AdminRegisteringDao {
	// 상품 등록
	public int insertProducts(List<Products> products);
	// 상품 이미지 등록
	public int insertPrdouctsImages(List<Products> products);
}

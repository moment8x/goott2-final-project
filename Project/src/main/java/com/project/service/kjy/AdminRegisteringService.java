package com.project.service.kjy;

import java.util.List;

import com.project.vodto.kjy.Products;

public interface AdminRegisteringService {
	// 상품 정보 등록
	public boolean inputProducts(List<Products> products);
}

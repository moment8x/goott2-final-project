package com.project.dao.kym;


import java.util.List;

import com.project.vodto.Product;
import com.project.vodto.kym.ProductsKym;

public interface DetailDAO {
	// no번 상세글 찾기
	ProductsKym selectDetailNO(String productId) throws Exception;

	}

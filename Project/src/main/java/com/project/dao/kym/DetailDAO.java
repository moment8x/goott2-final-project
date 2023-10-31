package com.project.dao.kym;


import java.util.List;

import com.project.vodto.Product;
import com.project.vodto.kym.Products;

public interface DetailDAO {
	// no번 상세글 찾기
	Products selectDetailNO(String productId) throws Exception;

	}

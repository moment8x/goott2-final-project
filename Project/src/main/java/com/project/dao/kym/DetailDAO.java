package com.project.dao.kym;


import java.util.List;

import com.project.vodto.Product;

public interface DetailDAO {
	// no번 상세글 찾기
	Product selectDetailNO(String productId) throws Exception;

	}

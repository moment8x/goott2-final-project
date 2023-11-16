package com.project.dao.kym.admin;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

public interface AdminProductDAO {
	
	// 전체 상품 조회
	int countAll() throws Exception;

}

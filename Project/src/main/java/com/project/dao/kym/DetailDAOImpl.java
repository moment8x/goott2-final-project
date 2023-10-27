package com.project.dao.kym;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.project.vodto.Product;

@Repository
public class DetailDAOImpl implements DetailDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.kym.mappers.detailMapper";

	@Override
	public Product selectDetailNO(String productId) throws Exception {
		System.out.println(productId);
		// 디테일 페이지 내용을 가져온다
		return ses.selectOne(ns + ".DetailNo", productId);
		
	}

}

package com.project.dao.kjy;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjy.Products;

@Repository
public class AdminRegisteringDaoImpl implements AdminRegisteringDao {
	
	private String ns = "com.project.mappers.adminRegisteringMapper";
	
	private SqlSession ses;

	@Override
	public int insertProducts(List<Products> products) {
		ses.insert(ns+".insertProducts", products);
		return 0;
	}

	@Override
	public int insertPrdouctsImages(List<Products> products) {
		// TODO Auto-generated method stub
		return 0;
	}

}

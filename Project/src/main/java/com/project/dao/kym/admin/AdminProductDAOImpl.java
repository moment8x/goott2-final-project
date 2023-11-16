package com.project.dao.kym.admin;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class AdminProductDAOImpl implements AdminProductDAO {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.project.mappers.adminProductMapper";
	
	
	@Override
	public int countAll() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".selectAllProductCount");
	}

}

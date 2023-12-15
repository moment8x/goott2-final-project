package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.CartResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminShoppingCartDAOImpl implements AdminShoppingCartDAO {
	
	private static String ns = "com.project.mappers.adminShoppingCartMapper";
	private final SqlSession ses;
	
	@Override
	public List<CartResponse> findCartInfoById(String memberId) {
		return ses.selectList(ns + ".selectCartInfo", memberId);
	}

}

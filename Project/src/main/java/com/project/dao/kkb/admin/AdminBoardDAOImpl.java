package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.PostCondition;
import com.project.vodto.kkb.PostResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminBoardDAOImpl implements AdminBoardDAO {
	
	private static String ns = "com.project.mappers.adminBoardMapper";
	private final SqlSession ses;

	@Override
	public List<PostResponse> findPostByInfo(PostCondition postCond) {		
		return ses.selectList(ns + ".selectPostInfo", postCond);
	}

	

}

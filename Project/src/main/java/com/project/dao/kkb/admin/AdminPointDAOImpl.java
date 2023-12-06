package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.PointInfoResponse;
import com.project.vodto.kkb.PointListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminPointDAOImpl implements AdminPointDAO {
	
	private static String ns = "com.project.mappers.adminPointMapper";
	private final SqlSession ses;
	
	@Override
	public PointInfoResponse findPointInfoById(String memberId) {
		return ses.selectOne(ns + ".selectPointInfo", memberId);
	}

	@Override
	public List<PointListResponse> findPointListById(String memberId) {
		return ses.selectList(ns + ".selectPointList", memberId);
	}

}

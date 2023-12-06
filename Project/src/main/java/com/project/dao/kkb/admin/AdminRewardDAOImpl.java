package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.RewardInfoResponse;
import com.project.vodto.kkb.RewardListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminRewardDAOImpl implements AdminRewardDAO {
	
	private static String ns = "com.project.mappers.adminRewardMapper";
	private final SqlSession ses;
	
	@Override
	public RewardInfoResponse findRewardInfoById(String memberId) {
		return ses.selectOne(ns + ".selectRewardInfo", memberId);
	}

	@Override
	public List<RewardListResponse> findRewardListById(String memberId) {
		return ses.selectList(ns + ".selectRewardList", memberId);
	}

}

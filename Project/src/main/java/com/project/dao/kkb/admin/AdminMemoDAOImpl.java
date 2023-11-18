package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoInfoCondition;
import com.project.vodto.kkb.MemoListResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminMemoDAOImpl implements AdminMemoDAO {
	
	private static String ns = "com.project.mappers.adminMemoMapper";
	private final SqlSession ses;
	
	@Override
	public List<MemoListResponse> findMemoById(MemoInfoCondition memoInfoCond) throws Exception {
		return ses.selectList(ns + ".selectMemoInfo", memoInfoCond);
	}

	@Override
	public void saveMemberMemo(MemoCondition memoCond) throws Exception {
		ses.insert(ns + ".insertMemberMemo", memoCond);
	}

}

package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.SearchMemberRequest;
import com.project.vodto.kkb.SearchMemberResponse;

@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO {

	private static String ns = "com.project.mappers.adminMemberMapper";
	private final SqlSession ses;
	
	public AdminMemberDAOImpl(SqlSession ses) {
		this.ses = ses;
	}

	@Override
	public int countAll() throws Exception {
		
		return ses.selectOne(ns + ".countAll");
	}
	
	@Override
	public List<SearchMemberResponse> findByInfo(SearchMemberRequest member) throws Exception {
		
		return ses.selectList(ns + ".findByInfo", member);
	}

	

}

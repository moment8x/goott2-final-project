package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.MemberBasicInfo;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberRecentInquiry;
import com.project.vodto.kkb.MemberRecentOrder;
import com.project.vodto.kkb.MemberRecentPost;
import com.project.vodto.kkb.MemberResponse;

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
	public List<MemberResponse> findByInfo(MemberCondition member) throws Exception {
		
		return ses.selectList(ns + ".findByInfo", member);
	}

	@Override
	public MemberBasicInfo findBasicInfoById(String memberId) throws Exception {
		
		return ses.selectOne(ns + ".findBasicInfoById", memberId);
	}

	@Override
	public List<MemberRecentOrder> findRecentOrderById(String memberId) throws Exception {
		
		return ses.selectList(ns + ".findRecentOrderById", memberId);
	}

	@Override
	public List<MemberRecentPost> findRecentPostById(String memberId) throws Exception {
		
		return ses.selectList(ns + ".findRecentPostById", memberId);
	}

	@Override
	public List<MemberRecentInquiry> findRecentInquiryById(String memberId) throws Exception {
		
		return ses.selectList(ns + ".findRecentInquiryById", memberId);
	}

	

}

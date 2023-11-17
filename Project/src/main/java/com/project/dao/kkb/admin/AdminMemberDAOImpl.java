package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.MemberBasicInfo;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
import com.project.vodto.kkb.MemberRecentInquiry;
import com.project.vodto.kkb.MemberRecentOrder;
import com.project.vodto.kkb.MemberRecentPost;
import com.project.vodto.kkb.MemberResponse;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminMemberDAOImpl implements AdminMemberDAO {

	private static String ns = "com.project.mappers.adminMemberMapper";
	private final SqlSession ses;

	@Override
	public int countAll() throws Exception {
		return ses.selectOne(ns + ".selectAllMemberCount");
	}
	
	@Override
	public List<MemberResponse> findByInfo(MemberCondition memberCond) throws Exception {
		return ses.selectList(ns + ".selectMemberInfo", memberCond);
	}

	@Override
	public MemberBasicInfo findBasicInfoById(String memberId) throws Exception {
		return ses.selectOne(ns + ".selectBasicInfo", memberId);
	}

	@Override
	public List<MemberRecentOrder> findRecentOrderById(String memberId) throws Exception {
		return ses.selectList(ns + ".selectRecentOrder", memberId);
	}

	@Override
	public List<MemberRecentPost> findRecentPostById(String memberId) throws Exception {
		return ses.selectList(ns + ".selectRecentPost", memberId);
	}

	@Override
	public List<MemberRecentInquiry> findRecentInquiryById(String memberId) throws Exception {
		return ses.selectList(ns + ".selectRecentInquiry", memberId);
	}

	@Override
	public MemberParam findDetailInfoById(String memberId) throws Exception {
		return ses.selectOne(ns + ".selectMemberDetailInfo", memberId);
	}

	@Override
	public int changeMemberDetailInfo(MemberParam member) throws Exception {
		return ses.update(ns + ".updateMemberDetailInfo", member);
	}

	

}

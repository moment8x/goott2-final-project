package com.project.dao.member;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession ses;

	private static String ns = "com.project.mappers.memberMapper";
	// ---------------------------------------- 장민정 시작 ----------------------------------------
	@Override
	public boolean insertSignUp(Member member) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Member selectMyInfo(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateMyInfo(Member member) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateWithdraw(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<MyPageOrderList> selectOrderHistory(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".getOrderList", memberId);
	}

	@Override
	public int selectOrderProductCount(List<Integer> orderNo) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".getProductCount", orderNo);
	}

	@Override
	public List<Integer> selectOrderNo(String memberId) {
		
		return ses.selectList(ns + ".getOrderNo", memberId);
	}
	// ---------------------------------------- 장민정 끝 -----------------------------------------
	// ---------------------------------------- 김진솔 시작 ----------------------------------------
	@Override
	public int selectId(String memberId) throws SQLException, NamingException {
		System.out.println("======= 회원가입 DAO - 아이디 중복 조회 =======");
		return ses.selectOne(ns + ".getId", memberId);
	}

	@Override
	public int insertMember(Member member) throws SQLException, NamingException {
		System.out.println("======= 회원가입 DAO - 회원 가입 =======");
		
		return ses.insert(ns + ".insertMember", member);
	}
	// ---------------------------------------- 김진솔 끝 -----------------------------------------
}

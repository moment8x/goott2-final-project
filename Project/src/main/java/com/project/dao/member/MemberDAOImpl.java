package com.project.dao.member;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.Member;
import com.project.vodto.OrderHistory;

public class MemberDAOImpl implements MemberDAO {

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
	public OrderHistory selectOrderHistory(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

}

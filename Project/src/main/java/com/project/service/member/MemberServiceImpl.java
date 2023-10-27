package com.project.service.member;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.member.MemberDAO;
import com.project.service.member.MemberService;
import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;
import com.project.vodto.OrderHistory;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO mDao;

	@Override
	public Boolean signUp(Member member) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member getMypage(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member getMyInfo(String memberId) throws SQLException, NamingException {
		
		return mDao.selectMyInfo(memberId);
	}

	@Override
	public Member setMyInfo(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean withdraw(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Board> getReview(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PointLog> getPointLog(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CustomerInquiry> getInquiries(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CouponLog> getCouponLog(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyPageOrderList> getOrderHistory(String memberId) throws SQLException, NamingException {
		
		return mDao.selectOrderHistory(memberId);
	}

	@Override
	public int getOrderProductCount(List<Integer> orderNo) throws SQLException, NamingException {
		
		return mDao.selectOrderProductCount(orderNo);
	}

	@Override
	public Member duplicateUserEmail(String email) throws SQLException, NamingException {

		return mDao.duplicateUserEmail(email);
	}

}

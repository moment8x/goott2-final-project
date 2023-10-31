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
	// --------------------------------------- 장민정 시작 ---------------------------------------
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
	
	@Override
	public List<Integer> getOrderNo(String memberId) throws SQLException, NamingException {
		// TODO Auto-generated method stub
		return null;
	}
	// --------------------------------------- 장민정 끝 ----------------------------------------
	// --------------------------------------- 김진솔 시작 ---------------------------------------
	@Override
	public boolean checkedDuplication(String memberId) throws SQLException, NamingException {
		System.out.println("======= 멤버(회원가입, 로그인) 서비스단 - 회원 정보 조회 =======");
		boolean result = false;
		// 회원 정보 조회
		if (!mDao.selectId(memberId)) {
			result = true;	// 중복된 아이디가 없을 때
		}
		
		System.out.println("======= 멤버(회원가입, 로그인) 서비스단 끝 =======");
		return result;
	}

	@Override
	public boolean insertMember(Member member) throws SQLException, NamingException {
		System.out.println("======= 멤버(회원가입) 서비스단 - 회원가입 =======");
		boolean result = false;
		
		// 회원 가입
		if (mDao.insertMember(member) == 1) {
			result = true;
		};
		System.out.println("member : " + member.toString());
		System.out.println("======= 멤버(회원가입) 서비스단 끝 =======");
		return result;
	}
	
	@Override
	public Member login(String memberId, String password) throws SQLException, NamingException {
		System.out.println("======= 멤버(로그인) 서비스단 - 로그인 =======");
		Member result = null;
		
		// Pwd 확인
		result = mDao.selectMember(memberId, password);
		
		if (result != null) {
			System.out.println(result.toString());
		}
		
		System.out.println("======= 멤버(로그인) 서비스단 끝 =======");
		return result;
	}
	// --------------------------------------- 김진솔 끝 ----------------------------------------	
}

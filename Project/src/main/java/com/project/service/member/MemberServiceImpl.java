package com.project.service.member;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjs.upload.UploadDAO;
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
import com.project.vodto.UploadFiles;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO mDao;
	@Inject
	private UploadDAO uDao;
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
	public boolean setMyInfo(String memberId, Member modifyMemberInfo) throws SQLException, NamingException {
		boolean result = true;
		
		if(modifyMemberInfo.getPassword() != null) {
			mDao.updatePwd(memberId, modifyMemberInfo);			
		}else if(modifyMemberInfo.getPhoneNumber() != null) {
			mDao.updatePhoneNumber(memberId, modifyMemberInfo);
		}else if(modifyMemberInfo.getCellPhoneNumber() != null) {
			mDao.updateCellPhoneNumber(memberId, modifyMemberInfo);
		}else if(modifyMemberInfo.getEmail() != null) {
			mDao.updateEmail(memberId, modifyMemberInfo);
		}else if(modifyMemberInfo.getAddress() != null) {
			mDao.updateAddr(memberId, modifyMemberInfo);
		}else if(modifyMemberInfo.getRefundBank() != null) {
			mDao.updateRefund(memberId, modifyMemberInfo);
		}else {
			result =false;
		}
		 
		return result;
	}

	@Override
	public Boolean withdraw(String memberId) throws SQLException, NamingException {
		boolean result = false;
		
		if(mDao.updateWithdraw(memberId) == 1) {
			result = true;
		}
		return result; 
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) throws SQLException, NamingException {
		
		return mDao.getShippingAddress(memberId);
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
	public Member duplicatePhoneNumber(String phoneNumber) throws SQLException, NamingException {
		return mDao.duplicatePhoneNumber(phoneNumber);
		
	}

	@Override
	public Member duplicateCellPhone(String cellPhoneNumber) throws SQLException, NamingException {
		
		return mDao.duplicateCellPhone(cellPhoneNumber);
	}

	@Override
	public int updateAuthentication(String memberId) throws SQLException, NamingException {
		
		return mDao.updateAuthentication(memberId);
	}

	@Override
	public boolean insertShippingAddress(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException {
		boolean result = false;
		
		if(mDao.addShippingAddress(memberId, tmpAddr) == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean shippingAddrModify(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException {
		boolean result = false;
			
			if(mDao.shippingAddrModify(memberId, tmpAddr) == 1) {
				result = true;
			}
			
		return result;

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
	@Transactional(rollbackFor = Exception.class)
	public boolean insertMember(Member member, UploadFiles file) throws SQLException, NamingException {
		System.out.println("======= 멤버(회원가입) 서비스단 - 회원가입 =======");
		boolean result = false;
		String newFileName = "";
		// 회원 가입 - 프로필 사진 저장
		if (file != null) {
			uDao.insertUploadFile(file);
			newFileName = file.getNewFileName();
		};
		// 회원 가입 - 회원 가입
		if (mDao.insertMember(member) == 1) {
			if (!newFileName.equals("")) {
				// 프로필사진이 있을 시.(update)
				mDao.updateProfile(member.getMemberId(), newFileName);
			}
			result = true;
		}
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

package com.project.service.member;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjs.upload.UploadDAO;
import com.project.dao.member.MemberDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;
import com.project.vodto.jmj.ChangeShippingAddr;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.jmj.PagingInfo;
import com.project.vodto.kjs.ShippingAddrDTO;
import com.project.vodto.kjs.SignUpDTO;
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
	@Transactional(rollbackFor = Exception.class)
	public Boolean withdraw(String memberId, String password) throws SQLException, NamingException {
		boolean result = false;
		
		//비밀번호가 일치한다면
		if(mDao.duplicatePwd(memberId, password) != null) { // 비밀번호가 일치
			//탈퇴시킨다
			if(mDao.updateWithdraw(memberId) == 1) {
				result = true;
			}			
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
	public Map<String, Object> getOrderHistory(String memberId, int pageNo) throws SQLException, NamingException {
		PagingInfo pi = pagination(pageNo, memberId);
		
		List<MyPageOrderList> lst = mDao.selectOrderHistory(memberId, pi);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("orderHistory", lst);
		result.put("pagination", pi);
		 
		return result;
	}

	private PagingInfo pagination(int pageNo, String memberId) throws SQLException, NamingException {
		PagingInfo result = new PagingInfo();
		
		//현재 페이지 번호 셋팅
		result.setPageNo(pageNo);
				
		//전체 주문 갯수
		result.setTotalPostCnt(mDao.getTotalOrderCnt(memberId));
				
		//총페이지 수 구하기
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());
				
		// 보여주기 시작할 row index번호 구하기
		result.setStartRowIndex();
				
		//몇개의 페이징 블럭이 나오는지
		result.setTotalPagingBlockCnt();
				
		//현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();
				
		//현재 블럭의 시작 페이지 번호
		result.setStartNumOfCurrentPagingBlock();
				
		//현재 블럭의 끝 페이지 번호 구하기
		result.setEndNumOfCurrentPagingBlock();
						
		return result;
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
	public boolean shippingAddrModify(String memberId, ShippingAddress tmpAddr, int addrSeq) throws SQLException, NamingException {
		boolean result = false;
			
			if(mDao.shippingAddrModify(memberId, tmpAddr, addrSeq) == 1) {
				result = true;
			}
			
		return result;

	}
	
	@Override
	public ShippingAddress getShippingAddr(int addrSeq, String memberId) throws SQLException, NamingException {
		
		return mDao.selectShippingAddr(addrSeq, memberId);
	}
	
	@Override
	public int deleteShippingAddr(String memberId, int addrSeq) throws SQLException, NamingException {
		
		return mDao.deleteShippingAddr(memberId, addrSeq);
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean setBasicAddr(String memberId, int addrSeq) throws SQLException, NamingException {
		boolean result = false;
		//1) 기본배송지 설정 버튼을 누르면 모든 basicAddr컬럼을 N으로 바꾼다
			if(mDao.allBasicAddrN(memberId) != 0) {
				//2) 해당 번호의 basic_addr을 Y로 바꿔준다.
				if(mDao.updateBasicAddr(memberId, addrSeq) != 0) {
					result = true;
				}
			}
		return result;	
	}
	
	@Override
	public List<DetailOrder> getDetailOrderInfo(String memberId, String orderNo) throws SQLException, NamingException {
		
		return mDao.selectDetailOrder(memberId, orderNo);
	}

	@Override
	public Map<String, Object> getOrderInfo(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("detailOrderInfo", mDao.selectDetailOrderInfo(memberId, orderNo));
		result.put("couponsHistory", mDao.getCouponsHistory(memberId, orderNo));
		result.put("bankTransfer", mDao.getBankTransfer(orderNo));
		
		return result;
	}
	
	@Override
	public boolean selectBasicAddr(String memberId, int addrSeq, String orderNo, String deliveryMessage) throws SQLException, NamingException {
		boolean result = false;
		
		ShippingAddress sa = mDao.selectShippingAddr(addrSeq, memberId);
		ChangeShippingAddr cs = new ChangeShippingAddr(sa.getRecipient(), sa.getRecipientContact(), sa.getZipCode(), sa.getAddress(), sa.getDetailAddress(), deliveryMessage);

		if(mDao.updateShippingAddr(memberId, orderNo, cs) !=0) {
			result = true;
		}
		
		return result;
	}
	
	@Override
	public List<MyPageOrderList> getCurOrderHistory(String memberId) throws SQLException, NamingException {
		
		return mDao.selectCurOrderHistory(memberId);
	}

	@Override
	public boolean updateDetailOrderAddr(DetailOrderInfo updateDetailOrderAddr, String memberId)
			throws SQLException, NamingException {
		boolean result = false;
		
		if(mDao.updateDetailOrderAddr(updateDetailOrderAddr, memberId) != 0) {
			result = true;
		}
		
		return result;
	}
	
	@Override
	public Map<String, Object> searchOrderStatus(String memberId, GetOrderStatusSearchKeyword keyword, int pageNo)
			throws SQLException, NamingException {
		PagingInfo pi = orderStatusPagination(pageNo, memberId, keyword);
		
		List<MyPageOrderList> lst = mDao.selectOrderStatus(memberId, keyword, pi);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("orderStatus", lst);
		result.put("pagination", pi);
		return result;
	}
	
	private PagingInfo orderStatusPagination(int pageNo, String memberId, GetOrderStatusSearchKeyword keyword) throws SQLException, NamingException {
		PagingInfo result = new PagingInfo();
		
		//현재 페이지 번호 셋팅
		result.setPageNo(pageNo);
				
		//전체 주문 갯수
		result.setTotalPostCnt(mDao.getTotalOrderStatusCnt(memberId, keyword));
				
		//총페이지 수 구하기
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());
				
		// 보여주기 시작할 row index번호 구하기
		result.setStartRowIndex();
				
		//몇개의 페이징 블럭이 나오는지
		result.setTotalPagingBlockCnt();
				
		//현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();
				
		//현재 블럭의 시작 페이지 번호
		result.setStartNumOfCurrentPagingBlock();
				
		//현재 블럭의 끝 페이지 번호 구하기
		result.setEndNumOfCurrentPagingBlock();
						
		return result;
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
	public boolean insertMember(SignUpDTO member, UploadFiles file) throws SQLException, NamingException {
		System.out.println("======= 멤버(회원가입) 서비스단 - 회원가입 =======");
		boolean result = false;
		String newFileName = "";
		// 회원 가입 - 프로필 사진 저장
		if (file != null) {
			if (ImgMimeType.contentTypeIsImage(file.getExtension())) {
				uDao.insertUploadImage(file);
				newFileName = file.getNewFileName();
			}
		};
		
		// 회원 가입 - 회원 가입
		if (mDao.insertMember(member) == 1) {
			// 배송지 설정
			ShippingAddrDTO shipping = new ShippingAddrDTO();
			shipping.setMemberId(member.getMemberId());
			shipping.setRecipient(member.getName());
			if (member.getCellPhoneNumber() != null && member.getCellPhoneNumber().equals("")) {
				shipping.setRecipientContact(member.getCellPhoneNumber());
			} else {
				shipping.setRecipientContact(member.getPhoneNumber());
			}
			shipping.setZipCode(member.getZipCode());
			shipping.setAddress(member.getAddress());
			shipping.setDetailAddress(member.getDetailedAddress());
			if (member.getBasicAddr() == null) {
				member.setBasicAddr("N");
			}
			shipping.setBasicAddr(member.getBasicAddr());
			
			// 배송지 추가
			if (mDao.insertShipping(shipping) == 1) {
				if (!newFileName.equals("")) {
					// 프로필사진이 있을 시.(update)
					mDao.updateProfile(member.getMemberId(), newFileName);
				}
				result = true;
			}
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

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
import com.project.service.member.MemberService;
import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.OrderHistory;
import com.project.vodto.PointLog;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;
import com.project.vodto.jmj.CancelDTO;
import com.project.vodto.jmj.ChangeShippingAddr;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetBankTransfer;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.jmj.PagingInfo;
import com.project.vodto.UploadFiles;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mDao;
	@Inject
	private UploadDAO uDao;

	// --------------------------------------- 장민정 시작
	// ---------------------------------------
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

		if (modifyMemberInfo.getPassword() != null) {
			mDao.updatePwd(memberId, modifyMemberInfo);
		} else if (modifyMemberInfo.getPhoneNumber() != null) {
			mDao.updatePhoneNumber(memberId, modifyMemberInfo);
		} else if (modifyMemberInfo.getCellPhoneNumber() != null) {
			mDao.updateCellPhoneNumber(memberId, modifyMemberInfo);
		} else if (modifyMemberInfo.getEmail() != null) {
			mDao.updateEmail(memberId, modifyMemberInfo);
		} else if (modifyMemberInfo.getAddress() != null) {
			mDao.updateAddr(memberId, modifyMemberInfo);
		} else if (modifyMemberInfo.getRefundBank() != null) {
			mDao.updateRefund(memberId, modifyMemberInfo);
		} else {
			result = false;
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean withdraw(String memberId, String password) throws SQLException, NamingException {
		boolean result = false;

		// 비밀번호가 일치한다면
		if (mDao.duplicatePwd(memberId, password) != null) { // 비밀번호가 일치
			// 탈퇴시킨다
			if (mDao.updateWithdraw(memberId) == 1) {
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
		List<GetBankTransfer> bankTransfer = mDao.selectBankTransfers(memberId);

		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("orderHistory", lst);
		result.put("pagination", pi);
		result.put("bankTransfer", bankTransfer);

		return result;
	}

	private PagingInfo pagination(int pageNo, String memberId) throws SQLException, NamingException {
		PagingInfo result = new PagingInfo();

		// 현재 페이지 번호 셋팅
		result.setPageNo(pageNo);

		// 전체 주문 갯수
		result.setTotalPostCnt(mDao.getTotalOrderCnt(memberId));

		// 총페이지 수 구하기
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());

		// 보여주기 시작할 row index번호 구하기
		result.setStartRowIndex();

		// 몇개의 페이징 블럭이 나오는지
		result.setTotalPagingBlockCnt();

		// 현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();

		// 현재 블럭의 시작 페이지 번호
		result.setStartNumOfCurrentPagingBlock();

		// 현재 블럭의 끝 페이지 번호 구하기
		result.setEndNumOfCurrentPagingBlock();

		return result;
	}

	@Override
	public int getOrderProductCount(String orderNo) throws SQLException, NamingException {

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
	public boolean insertShippingAddress(String memberId, ShippingAddress tmpAddr)
			throws SQLException, NamingException {
		boolean result = false;

		if (mDao.addShippingAddress(memberId, tmpAddr) == 1) {
			result = true;
		}

		return result;
	}

	@Override
	public boolean shippingAddrModify(String memberId, ShippingAddress tmpAddr, int addrSeq)
			throws SQLException, NamingException {
		boolean result = false;

		if (mDao.shippingAddrModify(memberId, tmpAddr, addrSeq) == 1) {
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
		// 1) 기본배송지 설정 버튼을 누르면 모든 basicAddr컬럼을 N으로 바꾼다
		if (mDao.allBasicAddrN(memberId) != 0) {
			// 2) 해당 번호의 basic_addr을 Y로 바꿔준다.
			if (mDao.updateBasicAddr(memberId, addrSeq) != 0) {
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
		result.put("bankTransfer", mDao.getBankTransfer(orderNo, memberId));
		result.put("orderQty", mDao.selectOrderProductCount(orderNo));

		return result;
	}

	@Override
	public boolean selectBasicAddr(String memberId, int addrSeq, String orderNo, String deliveryMessage)
			throws SQLException, NamingException {
		boolean result = false;

		ShippingAddress sa = mDao.selectShippingAddr(addrSeq, memberId);
		ChangeShippingAddr cs = new ChangeShippingAddr(sa.getRecipient(), sa.getRecipientContact(), sa.getZipCode(),
				sa.getAddress(), sa.getDetailAddress(), deliveryMessage);

		if (mDao.updateShippingAddr(memberId, orderNo, cs) != 0) {
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

		if (mDao.updateDetailOrderAddr(updateDetailOrderAddr, memberId) != 0) {
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

	private PagingInfo orderStatusPagination(int pageNo, String memberId, GetOrderStatusSearchKeyword keyword)
			throws SQLException, NamingException {
		PagingInfo result = new PagingInfo();

		// 현재 페이지 번호 셋팅
		result.setPageNo(pageNo);

		// 전체 주문 갯수
		result.setTotalPostCnt(mDao.getTotalOrderStatusCnt(memberId, keyword));

		// 총페이지 수 구하기
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());

		// 보여주기 시작할 row index번호 구하기
		result.setStartRowIndex();

		// 몇개의 페이징 블럭이 나오는지
		result.setTotalPagingBlockCnt();

		// 현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();

		// 현재 블럭의 시작 페이지 번호
		result.setStartNumOfCurrentPagingBlock();

		// 현재 블럭의 끝 페이지 번호 구하기
		result.setEndNumOfCurrentPagingBlock();

		return result;
	}

	@Override
	public Map<String, Object> selectCancelOrder(String memberId, String orderNo, int detailedOrderId)
			throws SQLException, NamingException {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("couponsHistory", mDao.getCouponsHistory(memberId, orderNo));
		result.put("selectCancelOrder", mDao.selectCancelOrder(memberId, orderNo, detailedOrderId));

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean cancelOrder(CancelDTO tmpCancel, String memberId) throws SQLException, NamingException {
		boolean result = false;

		Map<String, Object> order = selectCancelOrder(memberId, tmpCancel.getOrderNo(), tmpCancel.getDetailedOrderId());
		DetailOrder detailOrder = (DetailOrder) order.get("selectCancelOrder");
		List<CouponHistory> coupons = (List<CouponHistory>) order.get("couponsHistory");

		Member member = mDao.selectMyInfo(memberId);


		//환불테이블 인서트
		if (mDao.insertRefund(detailOrder.getProductId(), tmpCancel, detailOrder.getPaymentMethod()) > 0) {
			System.out.println("환불 저장 완");
			// 취소 인서트(무통장이라면)
			if (mDao.insertCancelOrder(detailOrder.getProductId(), tmpCancel.getReason(), tmpCancel.getAmount(),
					tmpCancel.getDetailedOrderId(), detailOrder.getPaymentMethod()) > 0) {
				System.out.println("취소 저장 완");
				// 디테일 프로덕트상태 업데이트
				mDao.updateDetailProductStatus(tmpCancel.getDetailedOrderId());
				System.out.println("디테일 상태 업데이트 완");
				// 환불계좌정보를 변경했다면
				mDao.updateRefundAccount(memberId, tmpCancel);
				System.out.println("환불 계좌 정보 변경 완");
				
				if (tmpCancel.getRefundRewardUsed() != 0) {
					// if(환불 적립금이 있다면)
					// 적립금 로그 인서트
					int totalReward = mDao.selectRewardBalance(memberId) + tmpCancel.getRefundRewardUsed();
					if(mDao.insertRewardLog(memberId, tmpCancel, totalReward) > 0) {
						System.out.println("적립금 로그 인서트 완");				
						// 멤버 총 적립금 업데이트
						int addReward = member.getTotalRewards() + tmpCancel.getRefundRewardUsed();
						mDao.updateMemberReward(addReward, memberId);
						System.out.println("멤버 총 적립금 업데이트 완");
					}
					result = true;
				}
				
				if (tmpCancel.getRefundPointUsed() != 0) {
					// -- if(환불 포인트가 있다면)
					// 포인트 로그 인서트
					int totalPoint = mDao.selectPointBalance(memberId) + tmpCancel.getRefundPointUsed();
					if(mDao.insertPointLog(memberId, tmpCancel.getRefundPointUsed(), tmpCancel.getOrderNo(), totalPoint) > 0) {
						System.out.println("포인트로그 인서트 완");
						// 멤버 총 포인트 업데이트
						int addPoint = member.getTotalPoints() + tmpCancel.getRefundPointUsed();
						mDao.updateMemberPoint(addPoint, memberId);
						System.out.println("멤버 총 포인트 업데이트 완");		
					}
					result = true;
				}
				
				if (coupons.size() != 0) {
					for (CouponHistory coupon : coupons) {
						// if(환불 쿠폰이 있다면)
						// 쿠폰로그 사용일, 사용한 주문번호 null로 업데이트
						if(mDao.updateCouponLog(coupon.getCouponLogsSeq()) > 0) {
							System.out.println("쿠폰로그 업데이트 완");
							// 멤버 총 쿠폰갯수 업데이트
							int couponCnt = mDao.selectCouponCnt(memberId, tmpCancel.getOrderNo());
							mDao.updateMemeberTotalCoupon(couponCnt, memberId);
							System.out.println("멤버 총 쿠폰갯수 업데이트 완");	
						}
					}
					result = true;
				}
				result = true;
			}

			result = true;
		}
		return result;
	}

	// --------------------------------------- 장민정 끝
	// ----------------------------------------
	// --------------------------------------- 김진솔 시작
	// ---------------------------------------
	@Override
	public boolean checkedDuplication(String memberId) throws SQLException, NamingException {
		System.out.println("======= 멤버(회원가입, 로그인) 서비스단 - 회원 정보 조회 =======");
		boolean result = false;
		// 회원 정보 조회
		if (!mDao.selectId(memberId)) {
			result = true; // 중복된 아이디가 없을 때
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
			if (ImgMimeType.contentTypeIsImage(file.getExtension())) {
				uDao.insertUploadImage(file);
				newFileName = file.getNewFileName();
			}
		}
		;
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

	// --------------------------------------- 김진솔 끝
	// ----------------------------------------

}

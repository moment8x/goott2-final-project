package com.project.service.member;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.naming.NamingException;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjs.upload.UploadDAO;
import com.project.dao.member.MemberDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.service.kkb.admin.AdminMemberService;
import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;
import com.project.vodto.UploadFiles;
import com.project.vodto.jmj.CancelDTO;
import com.project.vodto.jmj.ChangeShippingAddr;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetBankTransfer;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.jmj.MyPageReview;
import com.project.vodto.jmj.PagingInfo;
import com.project.vodto.jmj.PagingInfoPointLog;
import com.project.vodto.jmj.ReturnOrder;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.jmj.exchangeDTO;
import com.project.vodto.kjs.ShippingAddrDTO;
import com.project.vodto.kjs.SignUpDTO;
import com.project.vodto.kjs.TermsOfSignUpVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mDao;
	@Inject
	private UploadDAO uDao;
	@Inject
	private JavaMailSender mailSender;
	@Inject
	private AdminMemberService adminMemberService;

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

				// --------------- 김경배 ---------------
				/* 전체 회원 수 갱신 이벤트 발행 */
				adminMemberService.updateMemberCount();
				// ------------------------------------
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
	public Map<String, Object> memberInfo(String memberId, int pageNo) throws SQLException, NamingException {
		Map<String, Object> map = pagination(pageNo, memberId);
		PagingInfo pi = (PagingInfo) map.get("orderHistoryPaging");
		PagingInfoPointLog pointLogPaging =(PagingInfoPointLog)map.get("pointLogPaging");

		List<MyPageOrderList> lst = mDao.selectOrderHistory(memberId, pi);
		List<GetBankTransfer> bankTransfer = mDao.selectBankTransfers(memberId);

		Map<String, Object> result = new HashMap<String, Object>();
		List<MyPageReview> myReview = mDao.selectMyreview(memberId);
		for (MyPageReview review : myReview) {
			review.setContent(review.getContent().replace("\r\n", "<br/>"));
		}

		result.put("orderHistory", lst);
		result.put("pagination", pi);
		result.put("bankTransfer", bankTransfer);
		result.put("memberImg", mDao.selectMemeberProfileImg(memberId));
		result.put("wishlist", mDao.selectWishlist(memberId));
		result.put("pointLog", mDao.selectPointLog(memberId));
		result.put("rewardLog", mDao.selectRewardLog(memberId));
		result.put("couponLog", mDao.selectCouponLog(memberId));
		result.put("myReview", mDao.selectMyreview(memberId));
		result.put("cancelList", mDao.getCancelOrder(memberId));
		result.put("returnList", mDao.getReturnList(memberId));
		result.put("exchangeList", mDao.getExchangeList(memberId));
		result.put("pointLogPaging", pointLogPaging);

		return result;
	}

	private Map<String, Object> pagination(int pageNo, String memberId) throws SQLException, NamingException {
		PagingInfo orderHistory = new PagingInfo();
		PagingInfoPointLog pointLog = new PagingInfoPointLog();
		Map<String, Object> result = new HashMap<String, Object>();
//----------------------------------------주문내역---------------------------------------------------
		// 현재 페이지 번호 셋팅
		orderHistory.setPageNo(pageNo);

		// 전체 주문 갯수
		orderHistory.setTotalPostCnt(mDao.getTotalOrderCnt(memberId));

		// 총 주문 페이지 수 구하기
		orderHistory.setTotalPageCnt(orderHistory.getTotalPostCnt(), orderHistory.getViewPostCntPerPage());

		// 총 포인트로그 갯수
//		result.setTotalPointLogCnt(mDao.getTotalPointLogCnt(memberId));

		// 보여주기 시작할 row index번호 구하기
		orderHistory.setStartRowIndex();

		// 몇개의 페이징 블럭이 나오는지
		orderHistory.setTotalPagingBlockCnt();

		// 현재 페이지가 속한 페이징 블럭 번호
		orderHistory.setPageBlockOfCurrentPage();

		// 현재 블럭의 시작 페이지 번호
		orderHistory.setStartNumOfCurrentPagingBlock();

		// 현재 블럭의 끝 페이지 번호 구하기
		orderHistory.setEndNumOfCurrentPagingBlock();

		result.put("orderHistoryPaging", orderHistory);
//-------------------------------------------------------------------------------------------------
//------------------------------------------포인트로그---------------------------------------------
		// 현재 페이지 번호 셋팅
		pointLog.setPageNo(pageNo);

		// 총 주문 페이지 수 구하기
		pointLog.setTotalPointLogPageCnt(pointLog.getTotalPointLogCnt(), pointLog.getViewPostCntPerPage());

		// 총 포인트로그 갯수
		pointLog.setTotalPointLogCnt(mDao.getTotalPointLogCnt(memberId));

		// 보여주기 시작할 row index번호 구하기
		pointLog.setStartRowIndex();

		// 몇개의 페이징 블럭이 나오는지
		pointLog.setTotalPagingBlockCnt();

		// 현재 페이지가 속한 페이징 블럭 번호
		pointLog.setPageBlockOfCurrentPage();

		// 현재 블럭의 시작 페이지 번호
		pointLog.setStartNumOfCurrentPagingBlock();

		// 현재 블럭의 끝 페이지 번호 구하기
		pointLog.setEndNumOfCurrentPagingBlock();

		result.put("pointLogPaging", pointLog);

		return result;
	}

	@Override
	public int getOrderProductCount(String orderNo) throws SQLException, NamingException {

		return mDao.selectOrderProductCount(orderNo);
	}

	@Override
	public boolean duplicateUserEmail(String email) throws SQLException, NamingException, MessagingException {
		boolean result = false;
		if (mDao.duplicateUserEmail(email) != null) { // 이메일이 중복
			result = true;
		}
		return result;
	}

	public boolean emailSend(String email) throws MessagingException {
//		Map<String, Object> result = new HashMap<String, Object>();
		String code = UUID.randomUUID().toString();
		System.out.println("code!!!!!!!!!!!!!!!!!!!!!!!!!! : " + code);
//		this.emailCode = code;

		boolean result = false;

		String emailTo = email;
		String emailFrom = "game046@naver.com";
		String subject = "Dear Books 이메일 인증";
		String message = "코드 " + code + " 를 입력해서 인증을 해주세요.";

		MimeMessage mimeMsg = mailSender.createMimeMessage();
		MimeMessageHelper mimeHelper = new MimeMessageHelper(mimeMsg);

		mimeHelper.setFrom(emailFrom);
		mimeHelper.setTo(emailTo);
		mimeHelper.setSubject(subject);
		mimeHelper.setText(message);

		mailSender.send(mimeMsg);
		result = true;

		return result;
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
	@Transactional(rollbackFor = Exception.class)
	public boolean insertShippingAddress(String memberId, ShippingAddress tmpAddr)
			throws SQLException, NamingException {
		boolean result = false;

		if (tmpAddr.getBasicAddr() == 'Y') {
			System.out.println("기본배송지로 설정");
			if (mDao.allBasicAddrN(memberId) != 0) {
				mDao.addShippingAddress(memberId, tmpAddr);
				System.out.println("배송지 추가 완료");
				result = true;
			}
		} else if (tmpAddr.getBasicAddr() == 'N') {
			mDao.addShippingAddress(memberId, tmpAddr);
			System.out.println("기본배송지가 아닌 배송지 추가 완료");
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
//		List<MyPageOrderList> sp = mDao.selectPaymentMethodAndOrderNo(memberId);

//		for(MyPageOrderList po: sp) {
//			String paymentMethod = po.getPaymentMethod();
//			String orderNo = po.getOrderNo();
		List<MyPageOrderList> curOrder = mDao.selectCurOrderHistory(memberId);
//		}

		return curOrder;
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
	public Map<String, Object> selectCancelOrder(String memberId, String orderNo, int detailedOrderId, int selectQty)
			throws SQLException, NamingException {
		Map<String, Object> result = new HashMap<String, Object>();

		List<DetailOrder> detailOrder = mDao.selectDetailOrder(memberId, orderNo); // 해당주문에서 주문한 상품 전체
		List<CouponHistory> couponsHistory = mDao.getOrderCouponsHistory(memberId, orderNo); // 해당주문에서 사용한 쿠폰내역
		DetailOrder cancelOrder = mDao.selectCancelOrder(memberId, orderNo, detailedOrderId); // 해당주문에서 취소하려고 선택한 상품
		List<String> couponCategory = mDao.selectCouponCategoryKey(orderNo, memberId); // 해당주문에서 사용한 쿠폰카테고리 전부
		DetailOrderInfo detailOrderInfo = mDao.selectDetailOrderInfo(memberId, orderNo); // 해당 주문 주문상세

		result.put("couponsHistory", couponsHistory);
		result.put("cancelOrder", cancelOrder);

		int refundReward = 0; // 취소시 적립금 비교해서 업데이트해줘야할 적립금 금액
		int refundPoint = 0; // 취소시 포인트 비교해서 업데이트해줘야할 포인트 점수
		int refundAmount = 0; // 취소시 환불 금액
		int cancelProductPrice = cancelOrder.getProductPrice(); // 취소할 상품 금액
		int couponDiscount = cancelOrder.getCouponDiscount(); // 상품당 적용한 쿠폰 할인 금액
		int cancelPrice = (cancelProductPrice * selectQty) - couponDiscount; // 취소할 상품금액에서 쿠폰할인

		if (couponsHistory.size() > 0) {
			for (CouponHistory ch : couponsHistory) {
				// 해당 상품이 쿠폰사용주문에 있다면
				if (ch.getProductId().equals(cancelOrder.getProductId())) {
					// 해당 상품이 쿠폰 적용을 했다면
					if (ch.getCouponDiscount() > 0) {
						System.out.println("쿠폰적용을 했다");
						// 부분취소의 경우
//						취소할 상품금액 - 쿠폰 할인에서 시작

						result.put("calcRefund", calcRefund(cancelProductPrice, couponDiscount, cancelPrice,
								refundReward, refundPoint, refundAmount, detailOrderInfo));
//						
//						사용한 포인트 = 0 이라면 // 사용한 포인트가 없다
//						사용한 포인트도, 적립금도 없다면 상품금액만큼 돌려줌

						// 전체취소의 경우
//						적립금, 포인트 다 돌려줌 환불금액은 최종결제금액
						for (String category : couponCategory) {
							// 취소상품 카테고리키랑 쿠폰 카테고리키랑 일치한다면
							if (cancelOrder.getCategoryKey().equals(category)) {
								// for (int i = 0; i < detailOrder.size(); i++) {
								// 주문목록에 선택한상품이 있다면 삭제
//									if (detailOrder.get(i).getProductId().equals(cancelOrder.getProductId())) {
//										detailOrder.remove(i);
								System.out.println("detailOrder" + detailOrder.toString());
								// 삭제후에 주문목록에 상품이 존재한다면
								for (int i = couponsHistory.size() - 1; i >= 0; i--) {
									System.out.println("쿠폰히스토리 IIIIIIIII" + i);
//											CouponHistory couponApplyProduct = couponsHistory.get(i);
									if (couponsHistory.get(i).getCouponDiscount() > 0) {
										if (couponsHistory.get(i).getProductId().equals(cancelOrder.getProductId())) {
											System.out.println("쿠폰환불됨");
											result.put("status", "okCoupon");
											break;
										} else {
											System.out.println("쿠폰환불안됨");
											result.put("status", "noCoupon");
										}
									} else {
										System.out.println("쿠폰환불안됨");
										result.put("status", "noCoupon");
									}
								}
							}
						}
					} else if (ch.getCouponDiscount() == 0) {
						// 쿠폰 적용을 안 한 주문이다
						System.out.println("쿠폰환불안됨");
						result.put("status", "noCoupon");
						// 부분취소의 경우
//						취소할 상품금액에서 시작
						result.put("calcRefund", calcRefund(cancelProductPrice, couponDiscount, cancelPrice,
								refundReward, refundPoint, refundAmount, detailOrderInfo));
					}
				}
			}
		} else {
			// 쿠폰 적용을 안 한 주문이다
			System.out.println("쿠폰환불안됨");
			result.put("status", "noCoupon");
			// 부분취소의 경우
//			취소할 상품금액에서 시작
			result.put("calcRefund", calcRefund(cancelProductPrice, couponDiscount, cancelPrice, refundReward,
					refundPoint, refundAmount, detailOrderInfo));
		}
		return result;

	}

	// 부분취소시 환불 포인트, 적립금, 금액 계산
	private Map<String, Object> calcRefund(int cancelProductPrice, int couponDiscount, int cancelPrice,
			int refundReward, int refundPoint, int refundAmount, DetailOrderInfo detailOrderInfo) {
		Map<String, Object> result = new HashMap<String, Object>();

//		사용한 적립금 > 0 //적립금을 사용했다
		if (detailOrderInfo.getUsedReward() > 0) {
//			적립금이 취소할 상품 금액보다 크다면 
			if (detailOrderInfo.getUsedReward() > cancelPrice) {
//				적립금 - 취소상품금액 = 차액 
//				>> usedReward 차액 업데이트, 환불금액 없음
				refundReward = cancelPrice;
				result.put("refundReward", refundReward);
				result.put("refundPoint", refundPoint);
				result.put("refundAmount", refundAmount);
			} else {
				// 적립금이 취소할 상품 금액보다 작다면
//				취소상품금액 - 사용 적립금 = 차액 환불
//				usedReward 0 업데이트
				refundAmount = cancelPrice - detailOrderInfo.getUsedReward();
				refundReward = detailOrderInfo.getUsedReward();
				result.put("refundReward", refundReward);
				result.put("refundPoint", refundPoint);
				result.put("refundAmount", refundAmount);
			}
//		사용한 적립금 = 0 이라면 사용한 적립금이 없다
		} else if (detailOrderInfo.getUsedReward() == 0) {
			// 적립금이 없으니까 포인트 체크
			// 사용한 포인트 > 0 // 포인트를 사용했다
			if (detailOrderInfo.getUsedPoints() > 0) {
				// 취소할 상품 금액보다 포인트가 크다면
				if (detailOrderInfo.getUsedPoints() > cancelPrice) {
					// 포인트 - 취소상품금액 = 차액
					// >> usedPoint 차액 업데이트, 환불금액 없음
					refundPoint = cancelPrice;
					result.put("refundReward", refundReward);
					result.put("refundPoint", refundPoint);
					result.put("refundAmount", refundAmount);
				} else {
					// 취소할 상품 금액이 포인트보다 크다면
//					취소상품금액 - 사용 포인트 = 차액 환불
//					usedPoint 0 업데이트
					refundAmount = cancelPrice - detailOrderInfo.getUsedPoints();
					refundPoint = detailOrderInfo.getUsedPoints();
					result.put("refundReward", refundReward);
					result.put("refundPoint", refundPoint);
					result.put("refundAmount", refundAmount);
				}
			} else if (detailOrderInfo.getUsedPoints() == 0) {
				       
				refundAmount = cancelPrice;
				result.put("refundReward", refundReward);
				result.put("refundPoint", refundPoint);
				result.put("refundAmount", refundAmount);
			}
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> cancelOrder(CancelDTO tmpCancel, String memberId) throws SQLException, NamingException {
		Map<String, Object> result = new HashMap<String, Object>();
		boolean allCancel = true;
		int selectQty = 0;
		int detailedOrderId = 0;
		int amount = 0; // 상품가격 * 취소하려고 선택한 수량
		System.out.println(tmpCancel.toString());
		// 해당주문에서 취소하려고 선택한 상품

		for (int i = 0; i < tmpCancel.getDetailedOrderId().size(); i++) {
			detailedOrderId = tmpCancel.getDetailedOrderId().get(i);
		}
		DetailOrder cancelOrder = mDao.selectCancelOrder(memberId, tmpCancel.getOrderNo(), detailedOrderId);

		for (int i = 0; i < tmpCancel.getSelectQty().size(); i++) {
			selectQty = tmpCancel.getSelectQty().get(i);
			System.out.println(selectQty);
			amount = cancelOrder.getProductPrice() * tmpCancel.getSelectQty().get(i);
		}

		List<DetailOrder> detailOrder = mDao.selectDetailOrder(memberId, tmpCancel.getOrderNo()); // 해당주문에서 주문한 상품 전체
		DetailOrderInfo detailOrderInfo = mDao.selectDetailOrderInfo(memberId, tmpCancel.getOrderNo()); // 해당 주문 주문상세
		Member member = mDao.selectMyInfo(memberId);
		List<CouponHistory> couponsHistory = mDao.getOrderCouponsHistory(memberId, tmpCancel.getOrderNo()); // 해당주문에서
																											// 사용한 쿠폰내역
		int totalRefundAmount = amount + detailOrderInfo.getUsedPoints() + detailOrderInfo.getUsedReward()
				+ cancelOrder.getCouponDiscount(); // 취소하는 상품 할인전금액
		int productQuantity = mDao.selectProductQuantity(tmpCancel.getOrderNo(), cancelOrder.getProductId());
		int remainingQuantity = productQuantity - selectQty;
		System.out.println("productId" + cancelOrder.getProductId());
		System.out.println("productPrice" + cancelOrder.getProductPrice());

//		// 취소테이블 인서트
		if (mDao.insertCancelOrder(cancelOrder.getProductId(), tmpCancel.getReason(), amount, detailedOrderId,
				detailOrderInfo.getPaymentMethod(), memberId) > 0) {
			System.out.println("취소 저장 완");
//			// //환불테이블 인서트
			if (mDao.insertRefund(cancelOrder.getProductId(), totalRefundAmount, tmpCancel.getActualRefundAmount(),
					detailOrderInfo.getUsedReward(), detailOrderInfo.getUsedPoints(), cancelOrder.getCouponDiscount(),
					detailOrderInfo.getPaymentMethod()) > 0) {
				System.out.println("환불 저장 완");
				// 취소하는 상품 수량이랑 상품 주문수량이랑 일치하지 않는다면
				if (productQuantity != selectQty) {
					// 주문수량 업데이트
					mDao.updateProductQuantity(selectQty, tmpCancel.getOrderNo(), cancelOrder.getProductId(),
							remainingQuantity);
					System.out.println("주문수량 업데이트 완");
					result.put("remainingQuantity", remainingQuantity);
				} else { // 취소 하는 상품 수량이랑 상품 주문수량이랑 일치한다면
					mDao.updateProductQuantity(selectQty, tmpCancel.getOrderNo(), cancelOrder.getProductId(),
							remainingQuantity);
				}
				// 디테일 프로덕트상태 업데이트
				if(productQuantity != selectQty) { 
					// 취소하는 상품 수량이랑 선택한 상품 수량이랑 일치하지 않는다면 부분취소로 업데이트
					if(mDao.updateProductStatus(detailedOrderId) > 0) {
						System.out.println("디테일 상태 부분취소로 업데이트 완");						
					}
				}else {
					if (mDao.updateDetailProductStatus(detailedOrderId) > 0) {
						
						System.out.println("디테일 상태 주문취소로 업데이트 완");
						for (DetailOrder cancelDetail : detailOrder) {
//						// 모든 디테일 상품 상태가 취소라면 주문내역 배송상태 취소로 변경
							if (!"주문취소".equals(cancelDetail.getProductStatus())) {
								allCancel = false;
								break;
							} else {
								mDao.updatedeliveryStatus(memberId, tmpCancel.getOrderNo());
								System.out.println("주문내역 배송상태 변경 완");
							}
						}
					}					
				}

				System.out.println(tmpCancel.toString());
				// 실 결제금액 업데이트
				if (mDao.updateActualAmount(tmpCancel.getOrderNo(), tmpCancel.getActualRefundAmount(),
						detailOrderInfo.getPaymentMethod()) != 0) {
					System.out.println("실 결제금액 업데이트 완");
				}

//				// 환불계좌정보 업데이트
				if (mDao.updateRefundAccount(memberId, tmpCancel) != 0) {
					System.out.println("환불 계좌 정보 변경 완");
				}

//				// if(환불 적립금이 있다면)
				if (detailOrderInfo.getUsedReward() != 0) {
//					// 적립금 로그 인서트
					int totalReward = mDao.selectRewardBalance(memberId) + detailOrderInfo.getUsedReward();
					if (mDao.insertRewardLog(memberId, tmpCancel.getOrderNo(), detailOrderInfo.getUsedReward(),
							totalReward) > 0) {
						System.out.println("적립금 로그 인서트 완");
//						// 멤버 총 적립금 업데이트
						int addReward = member.getTotalRewards() + detailOrderInfo.getUsedReward();
						if (mDao.updateMemberReward(addReward, memberId) != 0) {
							System.out.println("멤버 총 적립금 업데이트 완");
							// 사용 적립금 0 으로 업데이트
							if (mDao.updateUsedReward(tmpCancel.getOrderNo()) != 0) {
								System.out.println("적립금 0으로 업데이트 완");
							}
						}
					}
				} else {
					if (detailOrderInfo.getUsedPoints() != 0) {
//					// -- if(환불 포인트가 있다면)
//					// 포인트 로그 인서트
						int totalPoint = mDao.selectPointBalance(memberId) + detailOrderInfo.getUsedPoints();
						if (mDao.insertPointLog(memberId, detailOrderInfo.getUsedPoints(), tmpCancel.getOrderNo(),
								totalPoint) > 0) {
							System.out.println("포인트로그 인서트 완");
//						// 멤버 총 포인트 업데이트
							int addPoint = member.getTotalPoints() + detailOrderInfo.getUsedPoints();
							if (mDao.updateMemberPoint(addPoint, memberId) != 0) {
								System.out.println("멤버 총 포인트 업데이트 완");
								// 사용 포인트 0 으로 업데이트
								if (mDao.updateUsedPoint(tmpCancel.getOrderNo()) != 0) {
									System.out.println("포인트 0으로 업데이트 완");
								}
							}
						}
					}
				}
//
				// 돌려줄 쿠폰이 있다면
				if (tmpCancel.getCouponName() != null && tmpCancel.getCouponName().size() != 0) {
					for (int i = 0; i < tmpCancel.getCouponName().size(); i++) {
						// 쿠폰로그 사용일, 사용한 주문번호 null로 업데이트
						if (mDao.updateCouponLog(memberId, tmpCancel.getOrderNo(),
								tmpCancel.getCouponName().get(i)) > 0) {
							System.out.println("쿠폰로그 업데이트 완");
							// 멤버 총 쿠폰갯수 업데이트
							int couponCnt = mDao.selectCouponCnt(memberId, tmpCancel.getOrderNo());
							mDao.updateMemeberTotalCoupon(couponCnt, memberId);
							System.out.println("멤버 총 쿠폰갯수 업데이트 완");
						}
					}

				}

			}
			result.put("status", "success");
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean returnOrder(ReturnOrder ro, String memberId) throws SQLException, NamingException {
		int detailedOrderId = 0;
		boolean result = false;
		boolean allApplyReturn = true;
		int selectQty = 0;

		for (int i = 0; i < ro.getDetailedOrderId().size(); i++) {
			detailedOrderId = ro.getDetailedOrderId().get(i);
		}
		for (int i = 0; i < ro.getSelectQty().size(); i++) {
			selectQty = ro.getSelectQty().get(i);
			System.out.println(selectQty);
		}

		List<DetailOrder> detailOrder = mDao.selectDetailOrder(memberId, ro.getOrderNo()); // 해당주문에서 주문한 상품 전체
		DetailOrderInfo detailOrderInfo = mDao.selectDetailOrderInfo(memberId, ro.getOrderNo()); // 해당 주문 주문상세
		DetailOrder retrunOrder = mDao.selectCancelOrder(memberId, ro.getOrderNo(), detailedOrderId);
		int productQuantity = mDao.selectProductQuantity(ro.getOrderNo(), retrunOrder.getProductId());
		int remainingQuantity = productQuantity - selectQty;

		if (mDao.insertReturn(retrunOrder.getProductId(), ro.getReturnReason(), detailedOrderId, memberId) > 0) {
			System.out.println("반품 인서트 완");
			if (mDao.insertReturnShippingAddress(ro) > 0) {
				System.out.println("회수 배송지 입력 완");
				if (mDao.updateRefundAccount(memberId, ro) > 0) {
					System.out.println("멤버 환불정보 업데이트 완");
					if (mDao.updateDetailProductStatusWithReturn(detailedOrderId) > 0) {
						System.out.println("디테일 상품 상태 업데이트 완");
						for (DetailOrder returnDetail : detailOrder) {
							// 모든 디테일 상품 상태가 반품신청이라면 주문내역 배송상태 반품신청으로 변경
							if (!"반품신청".equals(returnDetail.getProductStatus())) {
								allApplyReturn = false;
								break;
							} else {
								mDao.updatedeliveryStatusWithReturn(memberId, ro.getOrderNo());
								System.out.println("주문내역 배송상태 변경 완");
							}
							// 주문한 상품 수량이랑 반품하는 상품 수량이랑 일치하지 않는다면
							if (productQuantity != selectQty) {
								// 주문수량 업데이트
								mDao.updateProductQuantity(selectQty, ro.getOrderNo(), retrunOrder.getProductId(),
										remainingQuantity);
								System.out.println("주문수량 업데이트 완");
							} else {// 주문한 상품 수량이랑 반품하는 상품 수량이랑 일치한다면
								mDao.updateProductQuantity(selectQty, ro.getOrderNo(), retrunOrder.getProductId(),
										remainingQuantity);
							}
						}
					}
				}
			}
			result = true;
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean exchangeOrder(exchangeDTO ed, String memberId) throws SQLException, NamingException {

		boolean result = false;
		boolean allApplyExchange = true;
		int detailedOrderId = 0;

		for (int i = 0; i < ed.getDetailedOrderId().size(); i++) {
			detailedOrderId = ed.getDetailedOrderId().get(i);
		}

		List<DetailOrder> detailOrder = mDao.selectDetailOrder(memberId, ed.getOrderNo()); // 해당주문에서 주문한 상품 전체
		DetailOrderInfo detailOrderInfo = mDao.selectDetailOrderInfo(memberId, ed.getOrderNo()); // 해당 주문 주문상세
		DetailOrder exchangeOrder = mDao.selectCancelOrder(memberId, ed.getOrderNo(), detailedOrderId);

		if (mDao.insertReturnWithExchange(exchangeOrder.getProductId(), ed.getExchangeReason(), detailedOrderId) > 0) {
			System.out.println("반품테이블 인서트 완");
			if (mDao.insertExchangeShippingAddress(ed) > 0) {
				System.out.println("회수 배송지, 교환 배송지 인서트 완");
				if (mDao.updateDetailProductStatusWithExchange(detailedOrderId) > 0) {
					System.out.println("디테일 상품 상태 업데이트 완");
					for (DetailOrder exchangeDetail : detailOrder) {
						// 모든 디테일 상품 상태가 교환신청이라면 주문내역 배송상태 교환신청으로 변경
						if (!"교환신청".equals(exchangeDetail.getProductStatus())) {
							allApplyExchange = false;
							break;
						} else {
							mDao.updateDeliveryStatusWithExchange(memberId, ed.getOrderNo());
							System.out.println("주문내역 배송상태 변경 완");
						}
					}
				}
			}
			result = true;
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean insertUploadProfile(UploadFiles uf, String memberId) throws SQLException, NamingException {
		System.out.println(uf.toString());
		boolean result = false;

//		System.out.println(uploadFilesSeq);

		if (mDao.insertUploadProfile(uf) == 1) {
			System.out.println("멤버 프로필 이미지 업로드 완");
			int uploadFilesSeq = mDao.selectuploadFilesSeq(uf.getNewFileName());

			System.out.println(uploadFilesSeq);
			if (mDao.updateMemberProfile(uploadFilesSeq, memberId) == 1) {
				System.out.println("멤버 프로필 이미지 업데이트 완");
				result = true;
			}
		}
		return result;
	}

	@Override
	public boolean addShoppingCart(String memberId, String productId) throws SQLException, NamingException {
		boolean result = false;
		if (mDao.addShoppingCart(memberId, productId) == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public Map<String, Object> selectMyReview(String memberId, int postNo) throws SQLException, NamingException {
		Map<String, Object> result = new HashMap<String, Object>();

		MyPageReview review = mDao.selectMyReview(memberId, postNo);
		review.setContent(review.getContent().replace("<br/>", "\r\n"));
		List<UploadFiles> reviewUf = mDao.selectMyReviewUf(memberId, postNo);

		result.put("review", review);
		result.put("reviewUf", reviewUf);

		return result;
	}

	@Override
	public List<SelectWishlist> viewWishlist(String memberId) throws SQLException, NamingException {

		return mDao.viewWishlist(memberId);
	}

	// --------------------------------------- 장민정 끝
	// ----------------------------------------
	// --------------------------------------- 김진솔 시작
	// ---------------------------------------
	@Override
	public boolean checkedDuplication(String memberId) throws SQLException, NamingException {
		boolean result = false;
		// 회원 정보 조회
		if (!mDao.selectId(memberId)) {
			result = true; // 중복된 아이디가 없을 때
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean insertMember(SignUpDTO member) throws Exception {
		boolean result = false;
		String newFileName = "";
		
		// 회원 가입 - 프로필 사진 저장
		if (member.getFileList().size() > 0) {
			UploadFiles file = new UploadFiles();
			if (ImgMimeType.contentTypeIsImage(file.getExtension())) {
				uDao.insertUploadImage(file);
				newFileName = file.getNewFileName();
			}
		}

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
				// --------------- 김경배 ---------------
				/* 전체 회원 수 갱신 이벤트 발행 */
				adminMemberService.updateMemberCount();
				// ------------------------------------
			}
		}
		return result;
	}

	@Override
	public void sendEmail(String email, String code) throws MessagingException {
		String emailTo = email;
		String emailFrom = "lesilion@naver.com";
		String subject = "DeerBooks 이메일 인증";
		String message = "코드 " + code + " 를 이용하여 홈페이지에서 인증을 마치십시오";
		MimeMessage mimeMsg = mailSender.createMimeMessage();
		MimeMessageHelper mimeHelper = new MimeMessageHelper(mimeMsg);

		mimeHelper.setFrom(emailFrom);
		mimeHelper.setTo(emailTo);
		mimeHelper.setSubject(subject);
		mimeHelper.setText(message);

		mailSender.send(mimeMsg);
	}

	@Override
	public boolean confirmCode(String sessionCode, String userCode) {
		boolean result = false;
		
		if (sessionCode.equals(userCode)) {
			result = true;
		}

		return result;
	}

	@Override
	public String randomId(String memberId) {
		int leftLimit = 65;
		int rightLimit = 122;
		int stringLength = 10;
		Random random = new Random();
		StringBuilder buffer = new StringBuilder(stringLength);
		for (int i = 0; i < stringLength; i++) {
			int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
			if (randomLimitedInt != 91 || randomLimitedInt != 92 || randomLimitedInt != 93 || randomLimitedInt != 96) {
				buffer.append((char) randomLimitedInt);
			} else {
				i--;
			}
		}
		String generatedString = buffer.toString();
		System.out.println(generatedString);

		return generatedString + memberId;
	}

	@Override
	public List<TermsOfSignUpVO> getTerms() throws SQLException, NamingException {
		return mDao.getTerms();
	}

	// --------------------------------------- 김진솔 끝
	// ----------------------------------------

}

package com.project.dao.member;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Member;
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

		return ses.selectOne(ns + ".getMemberInfo", memberId);
	}

	@Override
	public int updateWithdraw(String memberId) throws SQLException, NamingException {
		
		return ses.update(ns + ".deleteUser", memberId);
	}

	@Override
	public List<MyPageOrderList> selectOrderHistory(String memberId, PagingInfo pi) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startRowIndex", pi.getStartRowIndex());
		params.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		params.put("memberId", memberId);
		
		return ses.selectList(ns + ".getOrderList", params);
	}

	@Override
	public int selectOrderProductCount(String orderNo) throws SQLException, NamingException {

		return ses.selectOne(ns + ".getProductCount", orderNo);
	}

	@Override
	public Member duplicateUserEmail(String email) throws SQLException, NamingException {

		return ses.selectOne(ns + ".getEmail", email);
	}
	
	@Override
	public Member duplicatePhoneNumber(String phoneNumber) throws SQLException, NamingException {

		return ses.selectOne(ns + ".getPhoneNumber", phoneNumber);
	}

	@Override
	public Member duplicateCellPhone(String cellPhoneNumber) {

		return ses.selectOne(ns + ".getCellPhoneNumber", cellPhoneNumber);
	}

	@Override
	public int updateAuthentication(String memberId) throws SQLException, NamingException {

		return ses.update(ns + ".updateAuthentication", memberId);
	}

	@Override
	public int updatePwd(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("password", modifyMemberInfo.getPassword());

		return ses.update(ns + ".updatePwd", params);
	}

	@Override
	public int updatePhoneNumber(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("phoneNumber", modifyMemberInfo.getPhoneNumber());

		return ses.update(ns + ".updatePhoneNumber", params);
	}

	@Override
	public int updateCellPhoneNumber(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("cellPhoneNumber", modifyMemberInfo.getCellPhoneNumber());

		return ses.update(ns + ".updatecellPhoneNumber", params);
	}

	@Override
	public int updateEmail(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("email", modifyMemberInfo.getEmail());

		return ses.update(ns + ".updateEmail", params);
	}

	@Override
	public int updateAddr(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("zipCode", modifyMemberInfo.getZipCode());
		params.put("address", modifyMemberInfo.getAddress());
		params.put("detailedAddress", modifyMemberInfo.getDetailedAddress());

		return ses.update(ns + ".updateAddr", params);
	}

	@Override
	public int updateRefund(String memberId, Member modifyMemberInfo) {
		Map<String, String> params = new HashMap<String, String>();

		params.put("memberId", memberId);
		params.put("refundBank", modifyMemberInfo.getRefundBank());
		params.put("refundAccount", modifyMemberInfo.getRefundAccount());
		params.put("accountHolder", modifyMemberInfo.getAccountHolder());

		return ses.update(ns + ".updateRefund", params);
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) {
		
		return ses.selectList(ns + ".getShippingAddress", memberId);
	}

	@Override
	public int addShippingAddress(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("recipient", tmpAddr.getRecipient());
		params.put("recipientContact", tmpAddr.getRecipientContact());
		params.put("zipCode", tmpAddr.getZipCode());
		params.put("address", tmpAddr.getAddress());
		params.put("detailAddress", tmpAddr.getDetailAddress());
		
		
		return ses.insert(ns + ".addShippingAddress", params);
	}

	@Override
	public int shippingAddrModify(String memberId, ShippingAddress tmpAddr, int addrSeq) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("recipient", tmpAddr.getRecipient());
		params.put("recipientContact", tmpAddr.getRecipientContact());
		params.put("zipCode", tmpAddr.getZipCode());
		params.put("address", tmpAddr.getAddress());
		params.put("detailAddress", tmpAddr.getDetailAddress());
		params.put("addrSeq", addrSeq);
		
		return ses.update(ns + ".updateShippingAddress", params);
	}
	
	@Override
	public ShippingAddress selectShippingAddr(int addrSeq, String memberId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("addrSeq", addrSeq);
		
		
		return ses.selectOne(ns + ".getShippingAddr", params);
	}
	
	@Override
	public int deleteShippingAddr(String memberId, int addrSeq) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("addrSeq", addrSeq);
		
		return ses.delete(ns + ".delShippingAddr", params);
	}
	
	@Override
	public int allBasicAddrN(String memberId) throws SQLException, NamingException {
		
		return ses.update(ns + ".allBasicAddrN", memberId);
	}

	@Override
	public int updateBasicAddr(String memberId, int addrSeq) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("addrSeq", addrSeq);
		
		return ses.update(ns + ".updateBasicAddr", params);
	}
	
	@Override
	public List<DetailOrder> selectDetailOrder(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectList(ns + ".getDetailOrder", params);
	}

	@Override
	public DetailOrderInfo selectDetailOrderInfo(String memberId, String orderNo) throws SQLException, NamingException {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("memberId", memberId);
			params.put("orderNo", orderNo);
		return ses.selectOne(ns + ".getDetailOrderInfo", params);
	}
	
	@Override
	public Member duplicatePwd(String memberId, String password) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("password", password);
		return ses.selectOne(ns + ".pwdCheck", params);
	}
	
	@Override
	public int updateShippingAddr(String memberId, String orderNo, ChangeShippingAddr cs) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		params.put("recipient", cs.getRecipient());
		params.put("recipientContact", cs.getRecipientContact());
		params.put("zipCode", cs.getZipCode());
		params.put("address", cs.getAddress());
		params.put("detailAddress", cs.getDetailAddress());
		params.put("deliveryMessage", cs.getDeliveryMessage());
		
		return ses.update(ns + ".selectBasicShippingAddr", params);
	}
	
	@Override
	public List<MyPageOrderList> selectCurOrderHistory(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".getCurOrderHistory", memberId);
	}
	
	@Override
	public int updateDetailOrderAddr(DetailOrderInfo updateDetailOrderAddr, String memberId)
			throws SQLException, NamingException {		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", updateDetailOrderAddr.getOrderNo());
		params.put("recipientName", updateDetailOrderAddr.getRecipientName());
		params.put("recipientPhoneNumber", updateDetailOrderAddr.getRecipientPhoneNumber());
		params.put("zipCode", updateDetailOrderAddr.getZipCode());
		params.put("shippingAddress", updateDetailOrderAddr.getShippingAddress());
		params.put("detailedShippingAddress", updateDetailOrderAddr.getDetailedShippingAddress());
		params.put("deliveryMessage", updateDetailOrderAddr.getDeliveryMessage());
		
		return ses.update(ns + ".updateDetailOrderAddr", params);
	}
	
	@Override
	public List<CouponHistory> getCouponsHistory(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectList(ns + ".getCouponsHistory", params);
	}
	
	@Override
	public GetBankTransfer getBankTransfer(String orderNo, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		return ses.selectOne(ns + ".getBankTransfer", params);
	}
	
	@Override
	public List<MyPageOrderList> selectOrderStatus(String memberId, GetOrderStatusSearchKeyword keyword, PagingInfo pi)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("beforeDeposit", keyword.getBeforeDeposit());
		params.put("beforeShipping", keyword.getBeforeShipping());
		params.put("shipping", keyword.getShipping());
		params.put("deliveryCompleted", keyword.getDeliveryCompleted());
		params.put("cancelList", keyword.getCancelList());
		params.put("exchangeList", keyword.getExchangeList());
		params.put("returnList", keyword.getReturnList());
		params.put("exchangeApply", keyword.getExchangeApply());
		params.put("returnApply", keyword.getReturnApply());
		
		params.put("sevenDaysAgo", keyword.getSevenDaysAgo());
		params.put("fifteenDaysAgo", keyword.getFifteenDaysAgo());
		params.put("aMonthAgo", keyword.getAMonthAgo());
		
		params.put("startRowIndex", pi.getStartRowIndex());
		params.put("viewPostCntPerPage", pi.getViewPostCntPerPage());
		
		return ses.selectList(ns + ".searchOrderStatus", params);
	}
	
	@Override
	public int getTotalOrderCnt(String memberId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".getTotalOrderCnt", memberId);
	}
	
	@Override
	public int getTotalOrderStatusCnt(String memberId, GetOrderStatusSearchKeyword keyword) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("beforeDeposit", keyword.getBeforeDeposit());
		params.put("beforeShipping", keyword.getBeforeShipping());
		params.put("shipping", keyword.getShipping());
		params.put("deliveryCompleted", keyword.getDeliveryCompleted());
		params.put("cancelList", keyword.getCancelList());
		params.put("exchangeList", keyword.getExchangeList());
		params.put("returnList", keyword.getReturnList());
		params.put("returnApply", keyword.getReturnApply());
		params.put("exchangeApply", keyword.getExchangeApply());
		
		params.put("sevenDaysAgo", keyword.getSevenDaysAgo());
		params.put("fifteenDaysAgo", keyword.getFifteenDaysAgo());
		params.put("aMonthAgo", keyword.getAMonthAgo());
		
		return ses.selectOne(ns + ".getOrderStatusCnt", params);
	}
	
	@Override
	public DetailOrder selectCancelOrder(String memberId, String orderNo, int detailedOrderId)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		params.put("detailedOrderId", detailedOrderId);
		return ses.selectOne(ns + ".selectCancelOrder", params);
	}
	
	@Override
	public int insertCancelOrder(String productId, String reason, int amount, int detailedOrderId, String paymentMethod)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("reason", reason);
		params.put("amount", amount);
		params.put("detailedOrderId", detailedOrderId);
		params.put("paymentMethod", paymentMethod);
		
		return ses.insert(ns + ".insertCancelOrder", params);
	}

	@Override
	public int updateDetailProductStatus(int detailedOrderId) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateDetailProductStatus", detailedOrderId);
	}

	@Override
	public int updateRefundAccount(String memberId, CancelDTO tmpCancel) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("refundBank", tmpCancel.getRefundBank());
		params.put("refundAccount", tmpCancel.getRefundAccount());
		params.put("accountHolder", tmpCancel.getAccountHolder());
		
		return ses.update(ns + ".updateRefundAccount", params);
	}

	@Override
	public int insertRefund(String productId, CancelDTO tmpCancel, String paymentMethod)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("amount", tmpCancel.getAmount());
		params.put("refundRewardUsed", tmpCancel.getRefundRewardUsed());
		params.put("refundPointUsed", tmpCancel.getRefundPointUsed());
		params.put("totalRefundAmount", tmpCancel.getTotalRefundAmount());
		params.put("paymentMethod", paymentMethod);
		
		return ses.insert(ns + ".insertRefund", params);
	}
	
	@Override
	public int insertRewardLog(String memberId, CancelDTO tmpCancel, int totalReward)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("refundRewardUsed", tmpCancel.getRefundRewardUsed());
		params.put("orderNo", tmpCancel.getOrderNo());
		params.put("balance", totalReward);
		
		return ses.insert(ns + ".insertRewardLog", params);
	}
	
	@Override
	public int updateMemberReward(int addReward, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("totalRewards", addReward);
		
		return ses.update(ns + ".updateMemberReward", params);
	}
	
	@Override
	public int insertPointLog(String memberId, int refundPointUsed, String orderNo, int totalPoint)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("point", refundPointUsed);
		params.put("orderNo", orderNo);
		params.put("balance", totalPoint);
		
		return ses.insert(ns + ".insertPointLog", params);
	}
	
	@Override
	public int selectRewardBalance(String memberId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".selectRewardBalance", memberId);
	}

	@Override
	public int selectPointBalance(String memberId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".selectPointBalance", memberId);
	}

	@Override
	public int updateMemberPoint(int addPoint, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("totalCouponCnt", addPoint);
		
		return ses.update(ns + ".updateMemberPoint", params);
	}

	@Override
	public int updateCouponLog(int couponLogsSeq) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateCouponLog", couponLogsSeq);
	}

	@Override
	public int selectCouponCnt(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectOne(ns + ".selectCouponCnt", params);
	}

	@Override
	public int updateMemeberTotalCoupon(int couponCnt, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("couponCnt", couponCnt);
		
		return ses.update(ns + ".updateMemeberTotalCoupon", params);
	}


	// ---------------------------------------- 장민정 끝 -----------------------------------------
	// ---------------------------------------- 김진솔 시작 ----------------------------------------
	@Override
	public boolean selectId(String memberId) throws SQLException, NamingException {
		System.out.println("======= 회원가입 DAO - 아이디 중복 조회 =======");
		boolean result = false;	// 중복x
		
		if (ses.selectOne(ns + ".getId", memberId) != null) {
			result = true;	// 중복. 존재함
		}
		
		return result;
	}

	public int insertMember(Member member) throws SQLException, NamingException {
		System.out.println("======= 회원가입 DAO - 회원 가입 =======");
		
		return ses.insert(ns + ".insertMember", member);
	}
	
	@Override
	public Member selectMember(String memberId, String password) throws SQLException, NamingException {
		System.out.println("======= 회원가입 DAO - 로그인 비밀번호 체크 =======");
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("password", password);
		
		return ses.selectOne(ns + ".login", param);
	}

	
	@Override
	public int updateProfile(String memberId, String newFileName) throws SQLException, NamingException {
		System.out.println("======= 회원 정보 수정 DAO - 프로필 사진 변경 =======");
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("newFileName", newFileName);
		
		return ses.insert(ns + ".updateProfile", params);
	}
	// ---------------------------------------- 김진솔 끝 -----------------------------------------

}

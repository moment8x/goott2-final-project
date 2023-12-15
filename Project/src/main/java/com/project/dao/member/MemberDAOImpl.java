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
import com.project.vodto.PointLog;
import com.project.vodto.RewardLog;
import com.project.vodto.ShippingAddress;
import com.project.vodto.UploadFiles;
import com.project.vodto.jmj.CancelDTO;
import com.project.vodto.jmj.CancelListVO;
import com.project.vodto.jmj.ChangeShippingAddr;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetBankTransfer;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageCouponLog;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.jmj.PagingInfo;
import com.project.vodto.kjs.ShippingAddrDTO;
import com.project.vodto.kjs.SignUpDTO;
import com.project.vodto.kjs.TermsOfSignUpVO;
import com.project.vodto.jmj.ReturnOrder;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.jmj.exchangeDTO;
import com.project.vodto.jmj.MyPageReview;

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
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("recipient", tmpAddr.getRecipient());
		params.put("recipientContact", tmpAddr.getRecipientContact());
		params.put("zipCode", tmpAddr.getZipCode());
		params.put("address", tmpAddr.getAddress());
		params.put("detailAddress", tmpAddr.getDetailAddress());
		params.put("basicAddr", tmpAddr.getBasicAddr());
		
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
	public CouponHistory getCouponsHistory(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectOne(ns + ".getCouponsHistory", params);
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
	public int insertCancelOrder(String productId, String reason, int amount, int detailedOrderId, String paymentMethod, String memberId)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("reason", reason);
		params.put("amount", amount);
		params.put("detailedOrderId", detailedOrderId);
		params.put("paymentMethod", paymentMethod);
		params.put("memberId", memberId);
		
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
	public int insertRefund(String productId, int totalRefundAmount, int actualRefundAmount, int refundRewardUsed, int refundPointUsed, int refundCouponDiscount, String paymentMethod)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("totalRefundAmount", totalRefundAmount);
		params.put("actualRefundAmount", actualRefundAmount);
		params.put("refundRewardUsed", refundRewardUsed);
		params.put("refundPointUsed", refundPointUsed);
		params.put("refundCouponDiscount", refundCouponDiscount);
		params.put("paymentMethod", paymentMethod);
		
		return ses.insert(ns + ".insertRefund", params);
	}
	
	@Override
	public int insertRewardLog(String memberId, String orderNo, int refundRewardUsed, int totalReward) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("refundRewardUsed", refundRewardUsed);
		params.put("orderNo", orderNo);
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
	public int updateCouponLog(String memberId, String orderNo, String couponName) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		params.put("couponName", couponName);
		
		return ses.update(ns + ".updateCouponLog", params);
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

	@Override
	public List<GetBankTransfer> selectBankTransfers(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectBankTransfers", memberId);
	}
	
	@Override
	public int updatedeliveryStatus(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.update(ns + ".updatedeliveryStatus", params);
	}

	@Override
	public int insertReturn(String productId, String returnReason, int detailedOrderId, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("reason", returnReason);
		params.put("detailedOrderId", detailedOrderId);
		params.put("memberId", memberId);
		
		return ses.insert(ns + ".insertReturn", params);
	}

	@Override
	public int insertReturnShippingAddress(ReturnOrder ro) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("zipNo", ro.getZipNo());
		params.put("addr", ro.getAddr());
		params.put("detailAddr", ro.getDetailAddr());
		params.put("returnMsg", ro.getReturnMsg());
		
		return ses.insert(ns + ".insertReturnShippingAddress", params);
	}
	
	@Override
	public int updateRefundAccount(String memberId, ReturnOrder ro) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("refundBank", ro.getRefundBank());
		params.put("refundAccount", ro.getRefundAccount());
		params.put("accountHolder", ro.getAccountHolder());
		params.put("memberId", memberId);
		
		return ses.update(ns + ".updateRefundAccountWithReturn", params);
	}
	
	@Override
	public int updateDetailProductStatusWithReturn(int detailedOrderId) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateDetailProductStatusWithReturn", detailedOrderId);
	}
	
	@Override
	public int updatedeliveryStatusWithReturn(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.update(ns + ".updatedeliveryStatusWithReturn", params);
	}
	
	@Override
	public int insertReturnWithExchange(String productId, String exchangeReason, int detailedOrderId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("reason", exchangeReason);
		params.put("detailedOrderId", detailedOrderId);
		
		return ses.insert(ns + ".insertExchange", params);
	}

	@Override
	public int insertExchangeShippingAddress(exchangeDTO ed) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("returnZipNo", ed.getReturnZipNo());
		params.put("returnAddr", ed.getReturnAddr());
		params.put("returnDetailAddr", ed.getReturnDetailAddr());
		params.put("returnMsg", ed.getReturnMsg());
		params.put("exchangeZipNo", ed.getExchangeZipNo());
		params.put("exchangeAddr", ed.getExchangeAddr());
		params.put("exchangeDetailAddr", ed.getExchangeDetailAddr());
		params.put("exchangeMsg", ed.getExchangeMsg());
		
		return ses.insert(ns + ".insertExchangeShippingAddress", params);
	}

	@Override
	public int updateDetailProductStatusWithExchange(int detailedOrderId) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateDetailProductStatusWithExchange", detailedOrderId);
	}

	@Override
	public int updateDeliveryStatusWithExchange(String memberId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.update(ns + ".updateDeliveryStatusWithExchange", params);
	}
	
	@Override
	public int insertUploadProfile(UploadFiles uf) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("extension", uf.getExtension());
		params.put("originalFileName", uf.getOriginalFileName());
		params.put("newFileName", uf.getNewFileName());
		params.put("fileSize", uf.getFileSize());
		
		return ses.insert(ns+ ".insertUploadProfile", uf);
	}
	
	@Override
	public int selectuploadFilesSeq(String newFileName) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".selectuploadFilesSeq", newFileName);
	}

	@Override
	public int updateMemberProfile(int uploadFilesSeq, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("uploadFilesSeq", uploadFilesSeq);
		
		return ses.update(ns + ".updateMemberProfile", params);
	}

	@Override
	public String selectMemeberProfileImg(String memberId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".selectMemeberProfileImg", memberId);
	}
	
	@Override
	public List<SelectWishlist> selectWishlist(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns+".selectWishlist", memberId);
	}
	
	@Override
	public int addShoppingCart(String memberId, String productId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		
		return ses.insert(ns + ".addShoppingCart", params);
	}

	@Override
	public List<PointLog> selectPointLog(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectPointLog", memberId);
	}
	
	@Override
	public int getTotalPointLogCnt(String memberId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".getTotalPointLogCnt", memberId);
	}
	
	@Override
	public List<RewardLog> selectRewardLog(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectRewardLog", memberId);
	}
	
	@Override
	public List<MyPageCouponLog> selectCouponLog(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectCouponLog", memberId);
	}
	
	@Override
	public List<MyPageOrderList> selectPaymentMethodAndOrderNo(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectPaymentMethodAndOrderNo", memberId);
	}

	@Override
	public List<MyPageReview> selectMyreview(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".selectMyreview", memberId);
	}

	@Override
	public MyPageReview selectMyReview(String memberId, int postNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("postNo", postNo);
		
		return ses.selectOne(ns + ".selectMyReview", params);
	}

	@Override
	public List<UploadFiles> selectMyReviewUf(String memberId, int postNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("postNo", postNo);
		
		return ses.selectList(ns + ".selectMyReviewUf", params);
	}

	@Override
	public List<String> selectCouponCategoryKey(String orderNo, String memberId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectList(ns + ".selectCouponCategoryKey", params);
	}
	
	@Override
	public List<CouponHistory> getOrderCouponsHistory(String memberId, String orderNo)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("orderNo", orderNo);
		
		return ses.selectList(ns + ".getOrderCouponsHistory", params);
	}
	
	@Override
	public int selectDetailOrderId(String productId, String orderNo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("orderNo", orderNo);
		
		return ses.selectOne(ns + ".selectDetailOrderId", params);
	}
	
	@Override
	public int selectProductPrice(String productId) throws SQLException, NamingException {
		
		return ses.selectOne(ns + ".selectProductPrice", productId);
	}
	
	@Override
	public int selectProductQuantity(String orderNo, String productId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("orderNo", orderNo);
		
		return ses.selectOne(ns + ".selectproductQuantity", params);
	}
	
	@Override
	public int updateProductQuantity(int selectQty, String orderNo, String productId, int remainingQuantity)
			throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("selectQty", selectQty);
		params.put("orderNo", orderNo);
		params.put("productId", productId);
		params.put("remainingQuantity", remainingQuantity);
		
		return ses.update(ns + ".updateProductQuantity", params);
	}
	
	@Override
	public int updateActualAmount(String orderNo, int actualRefundAmount, String paymentMethod) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("actualRefundAmount", actualRefundAmount);
		params.put("orderNo", orderNo);
		params.put("paymentMethod", paymentMethod);
		
		return ses.update(ns + ".updateActualAmount", params);
	}
	
	@Override
	public int updateUsedReward(String orderNo) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateUsedReward", orderNo);
	}

	@Override
	public int updateUsedPoint(String orderNo) throws SQLException, NamingException {
	
		return ses.update(ns +".updateUsedPoint", orderNo);
	}
	
	@Override
	public List<CancelListVO> getCancelOrder(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".getCancelOrder", memberId);
	}
	
	@Override
	public List<CancelListVO> getReturnList(String memberId) throws SQLException, NamingException {
	
		return ses.selectList(ns + ".getReturnList", memberId);
	}

	@Override
	public List<CancelListVO> getExchangeList(String memberId) throws SQLException, NamingException {

		return ses.selectList(ns + ".getExchangeList", memberId);
	}
	
	@Override
	public List<SelectWishlist> viewWishlist(String memberId) throws SQLException, NamingException {
		
		return ses.selectList(ns + ".viewWishlist", memberId);
	}
	
	@Override
	public int updateProductStatus(int detailedOrderId) throws SQLException, NamingException {
		
		return ses.update(ns + ".updateProductStatus", detailedOrderId);
	}

	// ---------------------------------------- 장민정 끝 -----------------------------------------
	// ---------------------------------------- 김진솔 시작 ----------------------------------------
	@Override
	public boolean selectId(String memberId) throws SQLException, NamingException {
		boolean result = false;	// 중복x
		
		if (ses.selectOne(ns + ".getId", memberId) != null) {
			result = true;	// 중복. 존재함
		}
		
		return result;
	}

	public int insertMember(SignUpDTO member) throws Exception {
		return ses.insert(ns + ".insertMember", member);
	}
	
	@Override
	public Member selectMember(String memberId, String password) throws SQLException, NamingException {
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("password", password);
		
		return ses.selectOne(ns + ".login", param);
	}

	
	@Override
	public int updateProfile(String memberId, String newFileName) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("newFileName", newFileName);
		
		return ses.insert(ns + ".updateProfile", params);
	}
	
	@Override
	public int insertShipping(ShippingAddrDTO shipping) throws SQLException, NamingException {
		return ses.insert(ns + ".insertShipping", shipping);
	}
	
	@Override
	public List<TermsOfSignUpVO> getTerms() throws SQLException, NamingException {
		return ses.selectList(ns + ".getTerms");
	}
	// ---------------------------------------- 김진솔 끝 -----------------------------------------


}
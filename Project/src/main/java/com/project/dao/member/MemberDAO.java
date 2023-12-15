package com.project.dao.member;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

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
import com.project.vodto.jmj.ReturnOrder;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.jmj.exchangeDTO;
import com.project.vodto.jmj.MyPageReview;
import com.project.vodto.kjs.ShippingAddrDTO;
import com.project.vodto.kjs.SignUpDTO;
import com.project.vodto.kjs.TermsOfSignUpVO;

@Repository
public interface MemberDAO {
	// ----------------------------------- 장민정 시작 -----------------------------------
	// 회원가입
	boolean insertSignUp(Member member) throws SQLException, NamingException;
	// mypage 첫 화면에 띄울 자료들 가져오기
//	MemberMypage selectMypage(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 전체 가져오기
	Member selectMyInfo(String memberId) throws SQLException, NamingException;
	// 특정 회원 탈퇴(기록 저장)
	int updateWithdraw(String memberId) throws SQLException, NamingException;
	// 주문건당 주문 내역 가져오기
	List<MyPageOrderList> selectOrderHistory (String memberId, PagingInfo pi) throws SQLException, NamingException;
	
	// 주문건당 상품 총 갯수 가져오기
	int selectOrderProductCount(String orderNo) throws SQLException, NamingException;
	
	//이메일 중복검사
	Member duplicateUserEmail(String tmpEmail) throws SQLException, NamingException;
	
	//전화번호 중복검사
	Member duplicatePhoneNumber(String phoneNumber) throws SQLException, NamingException;
	
	//핸드폰번호 중복검사
	Member duplicateCellPhone(String cellPhoneNumber) throws SQLException, NamingException;
	
	//본인인증 성공시
	int updateAuthentication(String memberId) throws SQLException, NamingException;
	
	//비밀번호 변경
	int updatePwd(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	//전화번호 변경
	int updatePhoneNumber(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	// 핸드폰번호 변경
	int updateCellPhoneNumber(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	//이메일 변경
	int updateEmail(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	//회원정보 주소 변경
	int updateAddr(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	//환불정보 변경
	int updateRefund(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	
	//배송주소록 불러오기
	List<ShippingAddress> getShippingAddress(String memberId) throws SQLException, NamingException;
	
	//배송주소록 추가
	int addShippingAddress(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException;
	
	//배송주소록 수정
	int shippingAddrModify(String memberId, ShippingAddress tmpAddr, int addrSeq) throws SQLException, NamingException;
	
	//특정회원의 수정할 배송지가져오기
	ShippingAddress selectShippingAddr(int addrSeq, String memberId) throws SQLException, NamingException;
	
	//특정 회원의 배송지 삭제
	int deleteShippingAddr(String memberId, int addrSeq) throws SQLException, NamingException;
	
	// 특정회원의 기본배송지 설정 N으로 업데이트
	int allBasicAddrN(String memberId) throws SQLException, NamingException;
	
	// 특정 배송지 기본배송지로 설정
	int updateBasicAddr(String memberId, int addrSeq) throws SQLException, NamingException;

	// 주문 상품 상세정보 가져오기
	List<DetailOrder> selectDetailOrder(String memberId, String orderNo) throws SQLException, NamingException;

	// 주문상세정보 가져오기
	DetailOrderInfo selectDetailOrderInfo(String memberId, String orderNo) throws SQLException, NamingException;
	
	// 비밀번호 일치하는지 체크
	Member duplicatePwd(String memberId, String password) throws SQLException, NamingException;

	// 출고전, 입금전 배송주소록에서 선택해서 배송지 변경
	int updateShippingAddr(String memberId, String orderNo, ChangeShippingAddr cs) throws SQLException, NamingException;
	
	//최근 주문 3개 가져오기
	List<MyPageOrderList> selectCurOrderHistory(String memberId) throws SQLException, NamingException;
	
	// 출고전, 입금전 배송지를 새로운 배송지로 변경
	int updateDetailOrderAddr(DetailOrderInfo updateDetailOrderAddr, String memberId) throws SQLException, NamingException;
	
	//주문상세 쿠폰내역
	CouponHistory getCouponsHistory(String memberId, String orderNo) throws SQLException, NamingException;
	
	// 무통장 주문 내역 가져오기
	GetBankTransfer getBankTransfer(String orderNo, String memberId) throws SQLException, NamingException;
	
	//주문상태별 조회
	List<MyPageOrderList> selectOrderStatus(String memberId, GetOrderStatusSearchKeyword keyword, PagingInfo pi) throws SQLException, NamingException;
	
	//주문갯수 가져오기
	int getTotalOrderCnt(String memberId) throws SQLException, NamingException;
	
	//주문상태별로 주문갯수
	int getTotalOrderStatusCnt(String memberId, GetOrderStatusSearchKeyword keyword) throws SQLException, NamingException;
	
	//취소할 주문 가져오기
	DetailOrder selectCancelOrder(String memberId, String orderNo, int detailedOrderId) throws SQLException, NamingException;
	
	//취소테이블 인서트
	int insertCancelOrder(String productId, String reason,int amount, int detailedOrderId, String paymentMethod, String memberId) throws SQLException, NamingException;
	
	//취소할경우 디테일 상품상태 업데이트
	int updateDetailProductStatus(int detailedOrderId) throws SQLException, NamingException;
	
	//환불계좌 업데이트
	int updateRefundAccount(String memberId, CancelDTO tmpCancel) throws SQLException, NamingException;
	
	//환불테이블 인서트
	int insertRefund(String productId, int totalRefundAmount, int actualRefundAmount, int refundRewardUsed, int refundPointUsed, int refundCouponDiscount, String paymentMethod) throws SQLException, NamingException;
	
	//취소시 사용한 적립금이 있다면 적립금 로그 인서트
	int insertRewardLog(String memberId, String orderNo, int refundRewardUsed, int totalReward) throws SQLException, NamingException;
	
	//멤버 적립금 업데이트
	int updateMemberReward(int addReward, String memberId) throws SQLException, NamingException;
	
	//환불 포인트가 있다면 포인트로그 인서트
	int insertPointLog(String memberId, int refundPointUsed, String orderNo, int totalPoint) throws SQLException, NamingException;
	
	//적립금로그 balance가져오기
	int selectRewardBalance(String memberId) throws SQLException, NamingException;
	
	//포인트로그 balance가져오기
	int selectPointBalance(String memberId) throws SQLException, NamingException;
	
	//멤버 포인트 업데이트
	int updateMemberPoint(int addPoint, String memberId) throws SQLException, NamingException;
	
	//환불 쿠폰이 있다면 쿠폰로그 업데이트
	int updateCouponLog(String memberId, String orderNo, String couponName) throws SQLException, NamingException;
	
	//해당 주문의 사용쿠폰 갯수 가져오기
	int selectCouponCnt(String memberId, String orderNo) throws SQLException, NamingException;
	
	//환불 쿠폰이 있다면 쿠폰갯수 업데이트
	int updateMemeberTotalCoupon(int totalCouponCnt, String memberId) throws SQLException, NamingException;
	
	//해당유저의 무통장주문내역 가져오기
	List<GetBankTransfer> selectBankTransfers(String memberId) throws SQLException, NamingException;
	
	//모든 상품의 상태가 취소라면 주문내역 배송상태 업데이트
	int updatedeliveryStatus(String memberId, String orderNo) throws SQLException, NamingException;
	
	//반품 인서트
	int insertReturn(String productId, String returnReason, int detailedOrderId, String memberId) throws SQLException, NamingException;
	
	//반품 회수지 인서트
	int insertReturnShippingAddress(ReturnOrder ro) throws SQLException, NamingException;
	
	//반품 환불계좌 변경
	int updateRefundAccount(String memberId, ReturnOrder ro) throws SQLException, NamingException;
	
	//반품시 디테일 상태 변경
	int updateDetailProductStatusWithReturn(int detailedOrderId) throws SQLException, NamingException;

	//모든 디테일 상태가 반품신청이라면 주문내역 배송상태 변경
	int updatedeliveryStatusWithReturn(String memberId, String orderNo) throws SQLException, NamingException;
	
	//교환시 반품 테이블 인서트
	int insertReturnWithExchange(String productId, String exchangeReason, int detailedOrderId) throws SQLException, NamingException;
	
	//회수, 교환 배송지 인서트
	int insertExchangeShippingAddress(exchangeDTO ed) throws SQLException, NamingException;
	
	//디테일 프로덕트 상태 업데이트
	int updateDetailProductStatusWithExchange(int detailedOrderId) throws SQLException, NamingException;
	
	//모든 상태가 교환신청이라면 주문내역 상태 교환신청으로 바꾸기
	int updateDeliveryStatusWithExchange(String memberId, String orderNo)throws SQLException, NamingException;
	
	//멤버 프로필사진 인서트
	int insertUploadProfile(UploadFiles uf) throws SQLException, NamingException;
	
	//업로드파일 uploadFilesSeq 가져오기
	int selectuploadFilesSeq(String newFileName) throws SQLException, NamingException;
	
	//멤버테이블 프로필사진 업데이트
	int updateMemberProfile(int uploadFilesSeq, String memberId) throws SQLException, NamingException;
	
	//멤버 프로필사진 가져오기
	String selectMemeberProfileImg(String memberId) throws SQLException, NamingException;
	
	//찜목록 가져오기
	List<SelectWishlist> selectWishlist(String memberId) throws SQLException, NamingException;
	
	//찜목록에 있는 상품 장바구니 추가
	int addShoppingCart(String memberId, String productId) throws SQLException, NamingException;
	
	//포인트로그 가져오기
	List<PointLog> selectPointLog(String memberId) throws SQLException, NamingException;
	
	//포인트로그 총 갯수 가져오기
	int getTotalPointLogCnt(String memberId) throws SQLException, NamingException;
	
	//적립금로그 가져오기
	List<RewardLog> selectRewardLog(String memberId) throws SQLException, NamingException;
	
	//쿠폰로그 가져오기
	List<MyPageCouponLog> selectCouponLog(String memberId) throws SQLException, NamingException;
	
	//결제수단, 주문번호 가져오기
	List<MyPageOrderList> selectPaymentMethodAndOrderNo(String memberId) throws SQLException, NamingException;
	
	//작성한 리뷰 전체 가져오기
	List<MyPageReview> selectMyreview(String memberId) throws SQLException, NamingException;
	
	//작성한 리뷰 한개 가져오기
	MyPageReview selectMyReview(String memberId, int postNo) throws SQLException, NamingException;
	
	//작성한 리뷰 업로드 파일 가져오기
	List<UploadFiles> selectMyReviewUf(String memberId, int postNo) throws SQLException, NamingException;
	
	//주문에 적용한 쿠폰 카테고리 가져오기
	List<String> selectCouponCategoryKey(String orderNo, String memberId) throws SQLException, NamingException;
	
	//쿠폰사용금액 합치지 않은 쿠폰내역
	List<CouponHistory> getOrderCouponsHistory(String memberId, String orderNo) throws SQLException, NamingException;
	
	//디테일오더 아이디 가져오기
	int selectDetailOrderId(String productId, String orderNo) throws SQLException, NamingException;
	
	//상품 가격 가져오기
	int selectProductPrice(String productId) throws SQLException, NamingException;
	
	//선택한 상품 주문 수량 가져오기
	int selectProductQuantity(String orderNo, String productId) throws SQLException, NamingException;
	
	//선택한 상품 수량이랑 상품 주문수량이랑 일치하지 않으면 상품 주문수량 업데이트
	int updateProductQuantity(int selectQty, String orderNo, String productId, int remainingQuantity) throws SQLException, NamingException;
	
	//취소, 반품시 실 결제금액 업데이트
	int updateActualAmount(String orderNo, int actualRefundAmount, String paymentMethod) throws SQLException, NamingException;
	
	//적립금 환불시 사용 적립금 0으로 업데이트
	int updateUsedReward(String orderNo) throws SQLException, NamingException;
	
	//포인트 환불시 사용 포인트 0으로 업데이트
	int updateUsedPoint(String orderNo) throws SQLException, NamingException;
	
	//해당 유저의 취소 리스트 가져오기
	List<CancelListVO> getCancelOrder(String memberId) throws SQLException, NamingException;
	
	//해당 유저의 반품 리스트 가져오기
	List<CancelListVO> getReturnList(String memberId) throws SQLException, NamingException;
	
	//해당 유저의 교환 리스트 가져오기
	List<CancelListVO> getExchangeList(String memberId) throws SQLException, NamingException;
	
	//찜목록 최근 3개 가져오기
	List<SelectWishlist> viewWishlist(String memberId) throws SQLException, NamingException;
	
	//디테일 상품상태 부분취소로 업데이트
	int updateProductStatus(int detailedOrderId) throws SQLException, NamingException;
	// ----------------------------------- 장민정 끝 ------------------------------------
	// ----------------------------------- 김진솔 시작 -----------------------------------
	// 회원 아이디 중복 조회
	boolean selectId(String memberId) throws SQLException, NamingException;
	// 회원 가입
	int insertMember(SignUpDTO member) throws Exception;
	// 로그인(비밀번호 체크)
	Member selectMember(String memberId, String password) throws SQLException, NamingException;
	// 프로필사진 업데이트
	int updateProfile(String memberId, String newFileName) throws SQLException, NamingException;
	// 기본 배송지 설정
	int insertShipping(ShippingAddrDTO shipping) throws SQLException, NamingException;
	// 약관 가져오기
	List<TermsOfSignUpVO> getTerms() throws SQLException, NamingException;
	// ----------------------------------- 김진솔 끝 ------------------------------------
	
	

	
}
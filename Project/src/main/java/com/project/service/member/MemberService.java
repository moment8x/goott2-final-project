package com.project.service.member;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.naming.NamingException;

import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;
import com.project.vodto.UploadFiles;
import com.project.vodto.jmj.CancelDTO;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.GetOrderStatusSearchKeyword;
import com.project.vodto.jmj.MyPageOrderList;
import com.project.vodto.kjs.SignUpDTO;
import com.project.vodto.kjs.TermsOfSignUpVO;
import com.project.vodto.jmj.ReturnOrder;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.jmj.exchangeDTO;

public interface MemberService {
	// ----------------------------------- 장민정 시작 -----------------------------------
	// 회원가입
	Boolean signUp(Member member) throws SQLException, NamingException;
	// 특정 회원 정보 전체 가져오기(mypage 메인 가져오기)
	Member getMypage(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(select)
	Member getMyInfo(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(update)
	boolean setMyInfo(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	// 특정 회원 탈퇴
	Boolean withdraw(String memberId, String password) throws SQLException, NamingException;
	// 배송지 목록 조회
	List<ShippingAddress> getShippingAddress(String memberId) throws SQLException, NamingException;
	// 리뷰 조회
	List<Board> getReview(String memberId) throws SQLException, NamingException;
	// 포인트 로그
	List<PointLog> getPointLog(String memberId) throws SQLException, NamingException;
	// 1:1 문의 조회
	List<CustomerInquiry> getInquiries(String memberId) throws SQLException, NamingException;
	// 쿠폰 조회
	List<CouponLog> getCouponLog(String memberId) throws SQLException, NamingException;
	// 찜 목록 가져오기

	// 장바구니 목록 가져오기
	
	//마이페이지 정보 가져오기 + 페이징
	Map<String, Object> memberInfo(String memberId, int pageNo) throws SQLException, NamingException;
	
	//주문건당 총 상품 갯수 가져오기
	int getOrderProductCount(String orderNo) throws SQLException, NamingException;
	
	// 이메일 중복검사
	boolean duplicateUserEmail(String email) throws SQLException, NamingException, MessagingException;
	
	//이메일 전송
	boolean emailSend(String email) throws MessagingException;
	
	// 전화번호 중복검사
	Member duplicatePhoneNumber(String phoneNumber) throws SQLException, NamingException;
	
	//핸드폰번호 중복검사
	Member duplicateCellPhone(String cellPhoneNumber) throws SQLException, NamingException;
	
	//본인인증 성공시 
	int updateAuthentication(String memberId) throws SQLException, NamingException;
	
	//배송주소록 추가
	boolean insertShippingAddress(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException;
	
	//배송주소록 수정
	boolean shippingAddrModify(String memberId, ShippingAddress tmpAddr, int addrSeq) throws SQLException, NamingException;

	//특정 회원의 배송주소록 데이터 가져오기
	ShippingAddress getShippingAddr(int addrSeq, String memberId) throws SQLException, NamingException;
	
	//특정회원의 배송지 삭제
	int deleteShippingAddr(String memberId, int addrSeq) throws SQLException, NamingException;
	
	//기본배송지 설정
	boolean setBasicAddr(String memberId, int addrSeq) throws SQLException, NamingException;
	
	//주문상세페이지 상품 정보 가져오기
	List<DetailOrder> getDetailOrderInfo(String memberId, String orderNo) throws SQLException, NamingException;
	
	//주문상세페이지 정보가져오기
	Map<String, Object> getOrderInfo(String memberId, String orderNo) throws SQLException, NamingException;
	
	//출고전, 입금전 배송주소록에서 배송지선택해서 변경하기
	boolean selectBasicAddr(String memberId, int addrSeq, String orderNo, String deliveryMessage) throws SQLException, NamingException;
	
	//최근주문내역 3개 가져오기
	List<MyPageOrderList> getCurOrderHistory(String memberId) throws SQLException, NamingException;
	
	// 출고전, 입금전 배송지를 새로운 배송지로 변경
	boolean updateDetailOrderAddr(DetailOrderInfo updateDetailOrderAddr, String memberId) throws SQLException, NamingException;
	
	//주문내역 상태별 검색
	Map<String, Object> searchOrderStatus(String memberId, GetOrderStatusSearchKeyword keyword, int pageNo) throws SQLException, NamingException;
	
	//취소할 주문 선택
	Map<String, Object> selectCancelOrder(String memberId, String orderNo, int detailedOrderId, int selectQty) throws SQLException, NamingException;
	
	//출고전, 입금전 주문취소하기
	 Map<String, Object>  cancelOrder(CancelDTO tmpCancel, String memberId) throws SQLException, NamingException;
	
	//배송완료시 반품하기
	boolean returnOrder(ReturnOrder ro, String memberId) throws SQLException, NamingException;
	
	//배송완료시 교환하기
	boolean exchangeOrder(exchangeDTO ed, String memberId) throws SQLException, NamingException;
	
	//멤버 프로필 사진 업로드
	boolean insertUploadProfile(UploadFiles uf, String memberId) throws SQLException, NamingException;
	
	//찜 목록에 있는 상품 장바구니 추가
	boolean addShoppingCart(String memberId, String productId) throws SQLException, NamingException;
	
	//리뷰 한개 가져오기
	Map<String, Object> selectMyReview(String memberId, int postNo) throws SQLException, NamingException;
	
	//찜목록 최근 3개 가져오기
	List<SelectWishlist> viewWishlist(String memberId) throws SQLException, NamingException;
	// ------------------------------------ 장민정 끝 -----------------------------------
	// ----------------------------------- 김진솔 시작 -----------------------------------
	// 회원 아이디 중복 조회
	boolean checkedDuplication(String memberId) throws SQLException, NamingException;
	// 회원 가입
	boolean insertMember(SignUpDTO member) throws Exception;
	// 이메일 인증
	void sendEmail(String email, String code) throws MessagingException;
	// 코드 검증
	boolean confirmCode(String sessionCode, String userCode);
	// 랜덤한 변수 8자리 생성
	String randomId(String memberId);
	// 회원가입 시 약관 가져오기
	List<TermsOfSignUpVO> getTerms() throws SQLException, NamingException;
	// ------------------------------------ 김진솔 끝 -----------------------------------
	

}
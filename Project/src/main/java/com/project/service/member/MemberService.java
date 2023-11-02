package com.project.service.member;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;
import com.project.vodto.OrderHistory;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;

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
	Boolean withdraw(String memberId) throws SQLException, NamingException;
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
	
	//주문건당 주문내역 가져오기
	List<MyPageOrderList> getOrderHistory(String memberId) throws SQLException, NamingException;
	
	//주문건당 총 상품 갯수 가져오기
	int getOrderProductCount(List<Integer> orderNo) throws SQLException, NamingException;
	
	// 이메일 중복검사
	Member duplicateUserEmail(String email) throws SQLException, NamingException;
	
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

	// ------------------------------------ 장민정 끝 -----------------------------------
	// ----------------------------------- 김진솔 시작 -----------------------------------
	// 회원 아이디 중복 조회
	boolean checkedDuplication(String memberId) throws SQLException, NamingException;
	// 회원 가입
	boolean insertMember(Member member) throws SQLException, NamingException;
	// 로그인 시도
	Member login(String memberId, String password) throws SQLException, NamingException;
	// ------------------------------------ 김진솔 끝 -----------------------------------
	
	
	
	
}
package com.project.service.member;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.vodto.Board;
import com.project.vodto.CouponLog;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.Member;
import com.project.vodto.PointLog;
import com.project.vodto.ShippingAddress;

@Service
public interface MemberService {
	// 회원가입
	Boolean signUp(Member member) throws SQLException, NamingException;
	// 특정 회원 정보 전체 가져오기(mypage 메인 가져오기)
	Member getMypage(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(select)
	Member getMyInfo(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(update)
	Member setMyInfo(String memberId) throws SQLException, NamingException;
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
}
package com.project.dao.member;

import java.sql.SQLException;

import javax.naming.NamingException;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberDAO {
	// 회원가입
	boolean insertSignUp(Member member) throws SQLException, NamingException;
	// mypage 첫 화면에 띄울 자료들 가져오기
	MemberMypage selectMypage(String memberId) throws SQLException, NamginException;
	// 특정 회원 정보 전체 가져오기
	Member selectMyInfo(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(update)
	boolean updateMyInfo(Member member) throws SQLException, NamingException;
	// 특정 회원 탈퇴(기록 저장 및 삭제)
	boolean updateWithdraw(String memberId) throws SQLException, NamingException;
}
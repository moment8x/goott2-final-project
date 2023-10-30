package com.project.dao.member;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.springframework.stereotype.Repository;

import com.project.vodto.Member;
import com.project.vodto.MyPageOrderList;

@Repository
public interface MemberDAO {
	// 회원가입
	boolean insertSignUp(Member member) throws SQLException, NamingException;
	// mypage 첫 화면에 띄울 자료들 가져오기
//	MemberMypage selectMypage(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 전체 가져오기
	Member selectMyInfo(String memberId) throws SQLException, NamingException;
	// 특정 회원 정보 수정(update)
//	int updateMyInfo(String memberId, Member modifyMemberInfo) throws SQLException, NamingException;
	// 특정 회원 탈퇴(기록 저장 및 삭제)
	boolean updateWithdraw(String memberId) throws SQLException, NamingException;
	// 주문건당 주문 내역 가져오기
	List<MyPageOrderList> selectOrderHistory (String memberId) throws SQLException, NamingException;
	
	// 주문건당 상품 총 갯수 가져오기
	int selectOrderProductCount(List<Integer> orderNo) throws SQLException, NamingException;
	
	//이메일 중복검사
	Member duplicateUserEmail(String tmpEmail) throws SQLException, NamingException;
	
	//전화번호 중복검사
	Member duplicatePhoneNumber(String phoneNumber) throws SQLException, NamingException;
	
	//핸드폰번호 중복검사
	Member duplicateCellPhone(String cellPhoneNumber) throws SQLException, NamingException;
	
	//본인인증 성공시
	int updateAuthentication(String memberId) throws SQLException, NamingException;
	
	//비밀번호 변경
	int updatePwd(String memberId, Member modifyMemberInfo);
	
	//전화번호 변경
	int updatePhoneNumber(String memberId, Member modifyMemberInfo);
	
	// 핸드폰번호 변경
	int updateCellPhoneNumber(String memberId, Member modifyMemberInfo);
	
	//이메일 변경
	int updateEmail(String memberId, Member modifyMemberInfo);
	
	//회원정보 주소 변경
	int updateAddr(String memberId, Member modifyMemberInfo);
	
	//환불정보 변경
	int updateRefund(String memberId, Member modifyMemberInfo);
	
}
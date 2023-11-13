package com.project.dao.member;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.springframework.stereotype.Repository;

import com.project.vodto.Member;
import com.project.vodto.Product;
import com.project.vodto.ShippingAddress;
import com.project.vodto.jmj.ChangeShippingAddr;
import com.project.vodto.jmj.CouponHistory;
import com.project.vodto.jmj.DetailOrder;
import com.project.vodto.jmj.DetailOrderInfo;
import com.project.vodto.jmj.MyPageOrderList;

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
	
	//배송주소록 수정 추가
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
	List<CouponHistory> getCouponsHistory(String memberId, String orderNo) throws SQLException, NamingException;
	
	// ----------------------------------- 장민정 끝 ------------------------------------
	// ----------------------------------- 김진솔 시작 -----------------------------------
	// 회원 아이디 중복 조회
	boolean selectId(String memberId) throws SQLException, NamingException;
	// 회원 가입
	int insertMember(Member member) throws SQLException, NamingException;
	// 로그인(비밀번호 체크)
	Member selectMember(String memberId, String password) throws SQLException, NamingException;
	// 프로필사진 업데이트
	int updateProfile(String memberId, String newFileName) throws SQLException, NamingException;
	// ----------------------------------- 김진솔 끝 ------------------------------------
	
	
	
	
	

	
	
	
	
	
	
	
	
}
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
import com.project.vodto.MyPageOrderList;
import com.project.vodto.ShippingAddress;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.project.mappers.memberMapper";

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
	public List<MyPageOrderList> selectOrderHistory(String memberId) throws SQLException, NamingException {

		return ses.selectList(ns + ".getOrderList", memberId);
	}

	@Override
	public int selectOrderProductCount(List<Integer> orderNo) throws SQLException, NamingException {

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

		return ses.update(ns + ".updateRefund", params);
	}

	@Override
	public List<ShippingAddress> getShippingAddress(String memberId) {
		
		return null;
	}

	@Override
	public int addShippingAddress(String memberId, ShippingAddress tmpAddr) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("zipCode", tmpAddr.getZipCode());
		params.put("address", tmpAddr.getAddress());
		params.put("detailAddress", tmpAddr.getDetailAddress());
		
		
		return ses.insert(ns + ".addShippingAddress", params);
	}

}

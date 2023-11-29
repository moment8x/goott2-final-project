package com.project.dao.kjy;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

@Repository
public class LoginDaoImpl implements LoginDao {
	@Inject
	private SqlSession ses;
	private String ns = "com.project.mappers.loginMapper";

	// 로그인 확인
	@Override
	public Memberkjy selectLogin(LoginDTO loginDTO) throws Exception {
		
		return ses.selectOne(ns+".selectLoginUser", loginDTO);
	}

	// 로그인 성공시 최종 접속일 업데이트
	@Override
	public int updateLastAccess(String memberId) throws Exception {
		
		return ses.update(ns+".updateLatsAccess", memberId);
	}

	@Override
	public int updateRemember(String memberId, String key) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("key", key);
		
		return ses.update(ns+".updateRememberKey", params);
	}

	@Override
	public Memberkjy selectRememberCheck(String memberId, String key) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		System.out.println("id : " + memberId + ", " + "key : " + key);
		params.put("memberId", memberId);
		params.put("key", key);
		Memberkjy m = ses.selectOne(ns+".rememberCheck", params);
		System.out.println("member : " + m);
		
		return m;
	}

	@Override
	public Memberkjy selectMemberById(String id) throws Exception {
		
		return ses.selectOne(ns+".selectMemberById", id);
	}

	@Override
	public Memberkjy selectMemberByNameAndEmail(String userId, String email, String userName) throws Exception {
		Map<String,String> params = new HashMap<String, String>();
		
		params.put("userId", userId);
		params.put("userName", userName);
		params.put("email", email);
		Memberkjy member = ses.selectOne(ns+".selectMemberByNameAndEmail", params);
		System.out.println("멤버 : " + member);
		return member;
	}

	@Override
	public boolean updatePassword(String userId, String password) {
		boolean result = false;
		Map<String, String> params = new HashMap<String, String>();
		params.put("userId", userId);
		params.put("password", password);
		if(ses.update(ns+".updatePassword", params) == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean isAdminBySelectPermission(String id) throws Exception {
		boolean result = false;
		Memberkjy member = ses.selectOne(ns+".isAdminBySelectPermission", id);
		if(member != null) {
			result = true;
		}
		return result;
	}

}

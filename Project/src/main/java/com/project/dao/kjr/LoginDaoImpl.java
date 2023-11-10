package com.project.dao.kjr;

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
	public int updateLastAccess(String member_id) throws Exception {
		
		return ses.update(ns+".updateLatsAccess", member_id);
	}

	@Override
	public int updateRemember(String member_id, String key) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("key", key);
		
		return ses.update(ns+".updateRememberKey", params);
	}

	@Override
	public Memberkjy selectRememberCheck(String member_id, String key) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("key", key);
		
		return ses.selectOne(ns+".rememberCheck", params);
	}

	@Override
	public Memberkjy selectMemberById(String id) throws Exception {
		
		return ses.selectOne(ns+".selectMemberById", id);
	}

}

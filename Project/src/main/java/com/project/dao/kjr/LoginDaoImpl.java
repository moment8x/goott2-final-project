package com.project.dao.kjr;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

@Repository
public class LoginDaoImpl implements LoginDao {
	@Inject
	private SqlSession ses;
	private String ns = "com.project.mappers.listMapper";

	@Override
	public Memberkjy selectLogin(LoginDTO loginDTO) throws Exception {
		
		return ses.selectOne(ns+".selectLoginUser", loginDTO);
	}

}

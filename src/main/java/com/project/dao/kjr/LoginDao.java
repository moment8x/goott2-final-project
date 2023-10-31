package com.project.dao.kjr;

import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Member;

public interface LoginDao {
	public Member selectLogin(LoginDTO loginDTO) throws Exception;
}

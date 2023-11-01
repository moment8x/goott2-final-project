package com.project.dao.kjr;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

public interface LoginDao {
	public Memberkjy selectLogin(LoginDTO loginDTO) throws Exception;
}

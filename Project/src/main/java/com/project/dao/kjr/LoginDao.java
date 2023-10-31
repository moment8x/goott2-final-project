package com.project.dao.kjr;

import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Memberkjy;

public interface LoginDao {
	public Memberkjy selectLogin(LoginDTO loginDTO) throws Exception;
}

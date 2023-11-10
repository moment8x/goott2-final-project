package com.project.dao.kjr;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

public interface LoginDao {
	public Memberkjy selectLogin(LoginDTO loginDTO) throws Exception;
	
	public int updateLastAccess(String memeber_id) throws Exception;
	
	public int updateRemember(String member_id, String key) throws Exception;
	
	public Memberkjy selectRememberCheck(String member_id, String key) throws Exception;
	
	public Memberkjy selectMemberById(String id) throws Exception;
}

package com.project.service.kjy;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

public interface LoginService {
	public Memberkjy getLogin(LoginDTO LoginDTO) throws Exception;
	
	public Memberkjy getRememberCheck(String member_id, String key) throws Exception;
	
	public Memberkjy getMemberById(String id) throws Exception;
}

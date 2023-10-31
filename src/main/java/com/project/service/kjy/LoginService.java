package com.project.service.kjy;

import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Member;

public interface LoginService {
	public Member getLogin(LoginDTO LoginDTO) throws Exception;
}

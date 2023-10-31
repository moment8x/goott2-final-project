package com.project.service.kjy;

import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Memberkjy;

public interface LoginService {
	public Memberkjy getLogin(LoginDTO LoginDTO) throws Exception;
}

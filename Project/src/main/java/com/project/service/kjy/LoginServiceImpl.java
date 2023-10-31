package com.project.service.kjy;

import javax.inject.Inject;

//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.dao.kjr.LoginDao;
import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Memberkjy;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private LoginDao loginDao;

	@Override
	public Memberkjy getLogin(LoginDTO loginDTO) throws Exception {
		Memberkjy loginMember = loginDao.selectLogin(loginDTO);
		if(loginMember != null) {
			System.out.println("로그인 성공");
			System.out.println(loginMember.toString());
		} else {
			System.out.println("로그인 실패");
			System.out.println(loginMember);
		}
		return loginMember;
	}

}

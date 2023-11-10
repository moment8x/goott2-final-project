package com.project.service.kjy;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjr.LoginDao;
import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private LoginDao loginDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Memberkjy getLogin(LoginDTO loginDTO) throws Exception {
		Memberkjy loginMember = loginDao.selectLogin(loginDTO);
		if(loginMember != null) {
			System.out.println("로그인 성공");
			loginDao.updateLastAccess(loginMember.getMemberId());
//			System.out.println(loginMember.toString());
		} else {
			System.out.println("로그인 실패");
//			System.out.println(loginMember);
		}
		return loginMember;
	}


	@Override
	public Memberkjy getRememberCheck(String member_id, String key) throws Exception {
		// TODO Auto-generated method stub
		return loginDao.selectRememberCheck(member_id, key);
	}


	@Override
	public Memberkjy getMemberById(String id) throws Exception {
		// TODO Auto-generated method stub
		return loginDao.selectMemberById(id);
	}
}

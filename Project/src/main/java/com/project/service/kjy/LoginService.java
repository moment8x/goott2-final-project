package com.project.service.kjy;

import javax.mail.MessagingException;

import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

public interface LoginService {
	public Memberkjy getLogin(LoginDTO LoginDTO) throws Exception;
	
	public Memberkjy getRememberCheck(String member_id, String key) throws Exception;
	
	public Memberkjy getMemberById(String id) throws Exception;
	// 자동로그인 확인 키 저장
	public boolean saveRemember(String memberId, String key) throws Exception;
	// 아이디 찾기
	public boolean emailAuth(String email, String userName, String userId) throws Exception;
	// 이메일 보내기
	public boolean emailaSend(String email) throws MessagingException;
	// 이메일 코드 인증
	public Memberkjy validEmailCode(String emailCode);
	// 비밀번호 변경
	public boolean changePassword(String userId, String password);
	// 관리자 계정인지 확인
	public boolean isAdmin(String id) throws Exception;
}

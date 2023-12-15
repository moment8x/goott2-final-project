package com.project.service.kjy;

import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.protobuf.compiler.PluginProtos.CodeGeneratorResponse.File;
import com.project.dao.kjy.LoginDao;
import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private com.project.dao.kjy.LoginDao loginDao;
	@Inject
	private JavaMailSender mailSender;
	private String emailCode = "";
	private Memberkjy member = null;
	

	@Override
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


	@Override
	public boolean saveRemember(String memberId, String key) throws Exception {
		boolean result = false;
		int upddateRemember = loginDao.updateRemember(memberId, key);
		if(upddateRemember == 1) {
			result = true;
		}
		
		return result;
	}
	
	public boolean emailAuth(String email, String userName, String userId) throws Exception {
		boolean result = false;
		// 먼저 db에서 해당 이메일을 쓰는 사람이 있는지 확인
		Memberkjy findMember = loginDao.selectMemberByNameAndEmail(userId, email, userName);
		if(findMember != null) {
			this.member = findMember;
			if(emailaSend(email)) {
				result = true;
			}
		}
		return result;
	}
	
	public boolean emailaSend(String email) throws MessagingException{
		String code = UUID.randomUUID().toString();
		System.out.println("code!!!!!!!!!!!!!!!!!!!!!!!!!! : " + code);
		//System.setProperty("mail.debug", "true");
		System.clearProperty("mail.debug");
		this.emailCode = code;
		
		boolean result = false;
		
		String emailTo = email;
		String emailFrom = "game046@naver.com";
		String subject = "DeerBooks 이메일 인증";
		String message = "코드 " + code + " 를 이용하여 홈페이지에서 인증을 마치십시오";
		
		MimeMessage mimeMsg = mailSender.createMimeMessage();
		MimeMessageHelper mimeHelper = new MimeMessageHelper(mimeMsg);
		
		mimeHelper.setFrom(emailFrom);
		mimeHelper.setTo(emailTo);
		mimeHelper.setSubject(subject);
		mimeHelper.setText(message);
		
		mailSender.send(mimeMsg);
		
		result = true;
		
		return result;
	}


	@Override
	public Memberkjy validEmailCode(String emailCode) {
		if(this.emailCode.equals(emailCode)) {
			return this.member;
		}
		return null;
	}


	@Override
	public boolean changePassword(String userId, String password) {
		
		return loginDao.updatePassword(userId, password);
	}


	@Override
	public boolean isAdmin(String id) throws Exception {
		
		return loginDao.isAdminBySelectPermission(id);
	}
}

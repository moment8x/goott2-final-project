package com.project.service.kjy;

import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.project.dao.kjr.LoginDao;
import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	private LoginDao loginDao;
	@Inject
	private JavaMailSender mailSender;
	

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
	
	public void emailAuth(String email, String userName) throws Exception {
		System.out.println("!!111s");
		// 먼저 db에서 해당 이메일을 쓰는 사람이 있는지 확인
		Memberkjy findMember = loginDao.selectMemberByNameAndEmail(email, userName);
		if(findMember != null) {
			System.out.println("!!2222");
			emailaSend(email);
		}
		
	}
	
	public boolean emailaSend(String email) throws MessagingException{
		String code = UUID.randomUUID().toString();
		
		
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
}

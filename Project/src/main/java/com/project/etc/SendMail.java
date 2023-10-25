package com.project.etc;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class SendMail {
	private JavaMailSender mailSender;	// email 전송 기능의 기본이 되는 interface 
    private MimeMessage message;	
    private MimeMessageHelper messageHelper;	// MimeMessage를 만들 수 있는 클래스, 텍스트,img 등 html 형식으로 제공
    											// subj, content, from, to 등 넣음
	// 자동 생성자
    public void sendMail(JavaMailSender mailSender) throws MessagingException {	
        this.mailSender = mailSender;
        message = this.mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }

    public void setSubject(String subject) throws MessagingException {
        messageHelper.setSubject(subject);;	// 메일 제목
    }

    public void setText(String htmlContent) throws MessagingException {
        messageHelper.setText(htmlContent, true);	// 메일 내용
    }

    public void setFrom(String email) throws UnsupportedEncodingException, MessagingException {
        messageHelper.setFrom(email);	// 보내는 사람
    }

    public void setTo(String email) throws MessagingException {
        messageHelper.setTo(email);		// 받을 사람
    }

    public void addInline(String contentId, DataSource dataSource) throws MessagingException {	// addInline(삽입될 이미지의 id 애트리뷰트명, 파일의 경로)
        messageHelper.addInline(contentId, dataSource);		// 이미지 삽입
    }

    public void send() {
        mailSender.send(message);		// 메일 전송
    }
}

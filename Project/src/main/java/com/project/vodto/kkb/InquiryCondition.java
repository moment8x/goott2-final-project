package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;

@Getter
public class InquiryCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private String title;
	private String email;
	private String content;
	private String author;
	private String name;
	private String orderNo;
	private String answerStatus;
	private String inquiryType;
	private byte file;
	
	private InquiryCondition(Date createdDateStart, Date createdDateEnd, String title, String email, String content,
			String author, String name, String orderNo, String answerStatus, String inquiryType, byte file) {
		this.createdDateStart = createdDateStart;
		this.createdDateEnd = createdDateEnd;
		this.title = title;
		this.email = email;
		this.content = content;
		this.author = author;
		this.name = name;
		this.orderNo = orderNo;
		this.answerStatus = answerStatus;
		this.inquiryType = inquiryType;
		this.file = file;
	}
	
	public static InquiryCondition create (String createdDateStart, String createdDateEnd, String title, String email, String content,
			String author, String name, String orderNo, String answerStatus, String inquiryType, byte file) {
		
		createdDateStart = createdDateStart.equals("") ? "0000-01-01" : createdDateStart;
		createdDateEnd = createdDateEnd.equals("") ? "9999-12-31" : createdDateEnd;
		
		return new InquiryCondition(
				Date.valueOf(createdDateStart),
				Date.valueOf(createdDateEnd),
				title, 
				email, 
				content,
				author, 
				name, 
				orderNo, 
				answerStatus, 
				inquiryType,file);
	}	
}

	

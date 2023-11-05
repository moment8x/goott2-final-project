package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberRecentInquiry {
//	private String inquiryType;
	private String title;
	private String author;
	private Date createdDate;
	private String answerStatus;
}

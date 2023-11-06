package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberRecentInquiry {
//	private String inquiryType;
	private String title;
	private String author;
	private Date createdDate;
	private String answerStatus;
}

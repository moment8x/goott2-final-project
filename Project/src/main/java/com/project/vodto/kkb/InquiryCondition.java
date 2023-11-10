package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private String title;
	private String email;
	private String content;
	private String author;
	private String name;
	private String orderNo;
	private String status;
	private String inquiryType;
	private boolean file;
}

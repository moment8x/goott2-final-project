package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryResponse {
	private String inquiryType;
	private String title;
	private String orderNo;
	private String email;
	private String name;
	private String author;
	private Date createdDate;
	private boolean reply;
	private Date replyDate;
}

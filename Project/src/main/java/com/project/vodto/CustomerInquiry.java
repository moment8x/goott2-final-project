package com.project.vodto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CustomerInquiry {
	private int postNo;
	private String author;
	private Timestamp createdDate;
	private String title;
	private String content;
	private String answerStatus;
	private int ref;
	private int step;
	private int refOrder;
	private Timestamp answerDate;
	private String inquiryType;
	private String phoneNumber;
	private String email;
	private String orderNo;
}
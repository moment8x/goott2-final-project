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
	private int post_no;
	private String author;
	private Timestamp created_date;
	private String title;
	private String content;
	private int file;
	private String answer_status;
	private int ref;
	private int step;
	private int ref_order;
	private Timestamp answer_date;
}
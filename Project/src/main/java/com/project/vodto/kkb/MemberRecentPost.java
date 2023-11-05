package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberRecentPost {
	private String categoryName;
	private String subcategory;
	private String title;
	private String author;
	private Date createdDate;
}

package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberRecentPost {
	private String categoryName;
	private String subcategory;
	private String title;
	private String author;
	private Date createdDate;
}

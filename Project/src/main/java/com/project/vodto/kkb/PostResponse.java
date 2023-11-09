package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostResponse {
	private String categoryName;
	private String subcategory;
	private String title;
	private String name;
	private String author;
	private String status;
	private Timestamp createdDate;
}

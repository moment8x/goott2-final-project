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
	private boolean reply;
	private String author;
	private String name;
	private Timestamp createdDate;
}

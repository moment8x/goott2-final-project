package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private String categoryId;
	private String title;
	private String content;
	private String author;
	private byte reply;
//	private boolean comment;
	private byte file;
}

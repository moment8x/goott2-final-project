package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private int categoryId;
	private String title;
	private String content;
	private String author;
	private boolean reply;
//	private boolean comment;
	private boolean file;
}

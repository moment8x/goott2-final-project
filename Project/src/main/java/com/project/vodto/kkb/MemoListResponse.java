package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemoListResponse {
	private int no;
	private Timestamp createdDate;
	private String adminId;
	private char important;
	private String content;
}

package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemoInfoCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private String memberId;
	private byte important;
	private String content;
}

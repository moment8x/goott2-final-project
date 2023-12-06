package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.ToString;

@Getter
public class MemoInfoCondition {
	private Date createdDateStart;
	private Date createdDateEnd;
	private String memberId;
	private byte important;
	private String content;
	
	private MemoInfoCondition(Date createdDateStart, Date createdDateEnd, String memberId, byte important,
			String content) {
		this.createdDateStart = createdDateStart;
		this.createdDateEnd = createdDateEnd;
		this.memberId = memberId;
		this.important = important;
		this.content = content;
	}
	
	public static MemoInfoCondition create(String createdDateStart, String createdDateEnd, String memberId, byte important,
			String content) {
		
		createdDateStart = createdDateStart.equals("") ? "0000-01-01" : createdDateStart;
		createdDateEnd = createdDateEnd.equals("") ? "9999-12-31" : createdDateEnd;
		
		return new MemoInfoCondition(
				Date.valueOf(createdDateStart),
				Date.valueOf(createdDateEnd),
				memberId,
				important,
				content);
	}
	
}

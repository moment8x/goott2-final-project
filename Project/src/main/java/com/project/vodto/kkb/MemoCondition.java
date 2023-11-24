package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemoCondition {
	private String memberId;
	private String adminId;
	private String content;
	private byte important;
}

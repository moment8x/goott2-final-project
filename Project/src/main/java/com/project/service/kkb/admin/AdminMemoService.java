package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.MemoCondition;

public interface AdminMemoService {
	
	/* 회원 메모 조회 */
	Map<String, Object> getMemoById(MemoCondition memoCond) throws Exception;
}

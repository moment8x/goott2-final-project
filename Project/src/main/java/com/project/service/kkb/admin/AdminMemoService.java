package com.project.service.kkb.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoInfoCondition;

public interface AdminMemoService {
	
	/* 회원 메모 조회 */
	Map<String, Object> getMemoById(MemoInfoCondition memoInfoCond) throws Exception;

	/* 회원 메모 작성 */
	void addMemberMemo(MemoCondition memoCond, HttpServletRequest req) throws Exception;
}

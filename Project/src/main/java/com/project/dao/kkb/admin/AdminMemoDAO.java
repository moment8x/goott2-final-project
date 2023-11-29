package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoInfoCondition;
import com.project.vodto.kkb.MemoListResponse;

public interface AdminMemoDAO {

	/* 회원 메모 조회 */
	List<MemoListResponse> findMemoById(MemoInfoCondition memoInfoCond);
	
	/* 회원 메모 작성 */
	int saveMemberMemo(MemoCondition memoCond);
}

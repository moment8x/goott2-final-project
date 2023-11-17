package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.MemoCondition;
import com.project.vodto.kkb.MemoResponse;

public interface AdminMemoDAO {

	/* 회원 메모 조회 */
	List<MemoResponse> findMemoById(MemoCondition memoCond) throws Exception;
}

package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.PostCondition;

public interface AdminBoardService {
	
	/* 게시글 정보 조회 */
	Map<String, Object> getPostInfo(PostCondition postCond);
}

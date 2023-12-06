package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.PostCondition;
import com.project.vodto.kkb.PostResponse;

public interface AdminBoardDAO {

	/* 게시글 정보 조회 */
	List<PostResponse> findPostByInfo(PostCondition postCond);

}

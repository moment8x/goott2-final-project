package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.SearchMemberRequest;
import com.project.vodto.kkb.SearchMemberResponse;

public interface AdminMemberDAO {
	
	// 전체 회원 수 조회
	int countAll() throws Exception;
	
	//회원 정보 조회
	List<SearchMemberResponse> findByInfo(SearchMemberRequest member) throws Exception;

	
}

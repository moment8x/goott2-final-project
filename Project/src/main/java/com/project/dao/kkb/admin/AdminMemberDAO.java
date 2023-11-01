package com.project.dao.kkb.admin;

import java.util.List;
import java.util.Map;

import com.project.vodto.kkb.SearchMemberRequest;

public interface AdminMemberDAO {
	
	//회원 정보 조회
	List<SearchMemberRequest> findByInfo(SearchMemberRequest member) throws Exception;
}

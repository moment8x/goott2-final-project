package com.project.service.kkb.admin;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.vodto.kkb.SearchMemberRequest;

public interface AdminMemberService {
	
	// 회원 전체 수 조회
	Map<String, Object> getTotalMemberCount() throws Exception;
	
	// 회원 정보 조회
	Map<String, Object>	getMemberInfo(SearchMemberRequest member) throws Exception;

	
}

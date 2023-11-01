package com.project.service.kkb.admin;

import java.util.Map;

import org.springframework.context.event.ContextRefreshedEvent;

import com.project.vodto.kkb.SearchMemberRequest;

public interface AdminMemberService {
	
	// 전체 회원 수 조회
	Map<String, Object> getTotalMemberCount() throws Exception;
	
	// 회원 정보 조회
	Map<String, Object>	getMemberInfo(SearchMemberRequest member) throws Exception;

	// 전체 회원 수 조회 이벤트 발생
//	void updateMemberCount(ContextRefreshedEvent e) throws Exception;
	
}

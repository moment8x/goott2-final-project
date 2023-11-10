package com.project.service.kkb.admin;

import java.util.List;
import java.util.Map;

import com.project.vodto.kkb.MemberBasicInfo;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
import com.project.vodto.kkb.MemberRecentInquiry;
import com.project.vodto.kkb.MemberRecentOrder;
import com.project.vodto.kkb.MemberRecentPost;

public interface AdminMemberService {
	
	// 전체 회원 수 조회
	Map<String, Object> getTotalMemberCount() throws Exception;
	
	// 회원 정보 조회
	Map<String, Object>	getMemberInfo(MemberCondition member) throws Exception;

	// 전체 회원 수 조회 이벤트 발생
//	void updateMemberCount(ContextRefreshedEvent e) throws Exception;
	
	// CRM(고객 정보 관리) HOME
	Map<String, Object> getHomeDetailInfo(String memberId) throws Exception;
	
	// CRM 회원 상세정보
	Map<String, Object> getMemberDetailInfo(String memberId) throws Exception;

	// CRM 회원 상세정보 수정
	Map<String, Object> editMemberDetailInfo(MemberParam member) throws Exception;
}

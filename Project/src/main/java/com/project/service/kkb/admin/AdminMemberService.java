package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;

public interface AdminMemberService {
	
	/* 회원 수 갱신 이벤트 발행 */
	void updateMemberCount();
	
	/* 전체 회원 수 조회 */
	Map<String, Object> getTotalMemberCount();
	
	/* 회원 정보 조회 */
	Map<String, Object>	getMemberInfo(MemberCondition memberCond);
	
	/* CRM(고객 정보 관리) HOME */
	Map<String, Object> getHomeDetailInfo(String memberId);
	
	/* CRM 회원 상세정보 */
	Map<String, Object> getMemberDetailInfo(String memberId);

	/* CRM 회원 상세정보 수정 */
	int editMemberDetailInfo(MemberParam member);

	
}

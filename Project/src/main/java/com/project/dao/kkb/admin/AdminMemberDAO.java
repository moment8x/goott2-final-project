package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.MemberBasicInfo;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
import com.project.vodto.kkb.MemberRecentInquiry;
import com.project.vodto.kkb.MemberRecentOrder;
import com.project.vodto.kkb.MemberRecentPost;
import com.project.vodto.kkb.MemberResponse;

public interface AdminMemberDAO {
	
	/* 전체 회원 수 조회 */
	int countAll();
	
	/* 회원 정보 조회 */
	List<MemberResponse> findByInfo(MemberCondition memberCond);

	/* CRM 홈(기본 정보) */
	MemberBasicInfo findBasicInfoById(String memberId);
	
	/* CRM 홈(최근 주문 정보) */
	List<MemberRecentOrder> findRecentOrderById(String memberId);
	
	/* CRM 홈(최근 게시글) */
	List<MemberRecentPost> findRecentPostById(String memberId);
	
	/* CRM 홈(최근 1:1 문의) */
	List<MemberRecentInquiry> findRecentInquiryById(String memberId);
	
	/* CRM 회원 상세정보 */
	MemberParam findDetailInfoById(String memberId);
	
	/* CRM 회원 상세정보 수정 */
	int changeMemberDetailInfo(MemberParam member);
}

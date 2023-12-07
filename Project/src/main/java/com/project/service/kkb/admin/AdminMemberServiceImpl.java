package com.project.service.kkb.admin;

import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminMemberDAO;
import com.project.vodto.kkb.MemberBasicInfo;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;
import com.project.vodto.kkb.MemberRecentInquiry;
import com.project.vodto.kkb.MemberRecentOrder;
import com.project.vodto.kkb.MemberRecentPost;
import com.project.vodto.kkb.MemberResponse;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService {

	private final AdminMemberDAO adminMemberDao;
	private final MemberCountListener memberCount;
	private final ApplicationEventPublisher publisher;
	
	@Override
	public Map<String, Object> getTotalMemberCount() {
		
		int totalCount = 0;
		
		if(memberCount.getCurrentCount() == 0) {
			log.info("DB에서 전체 회원 수 조회");
			updateMemberCount();
			totalCount = memberCount.getCurrentCount();
		} 		
		/* DB에 접근 x, MemberCountListener에 저장해둔 값 가져옴 */
		totalCount = memberCount.getCurrentCount(); 
		Map<String, Object> result = new HashMap<>();
		result.put("total", totalCount);
		
		return result;
	}
	
	@Override
	public void updateMemberCount(){
		
		int memberCount = adminMemberDao.countAll();	
		log.info("회원 수 갱신");
		/* 이벤트 발행 */
		publisher.publishEvent(new TotalMemberCountEvent(memberCount));
	}	
	
	@Override
	public int editMemberDetailInfo(MemberParam member) {		
		return adminMemberDao.changeMemberDetailInfo(member);
	}
	
	@Override
	public Map<String, Object> getMemberDetailInfo(String memberId) {
		
		MemberParam detailInfo = adminMemberDao.findDetailInfoById(memberId);
		Map<String, Object> result = new HashMap<>();
		result.put("detailInfo", detailInfo);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getHomeDetailInfo(String memberId) {
		
		MemberBasicInfo basicInfo = adminMemberDao.findBasicInfoById(memberId);
		List<MemberRecentOrder> recentOrder = adminMemberDao.findRecentOrderById(memberId);
		List<MemberRecentPost> recentPost = adminMemberDao.findRecentPostById(memberId);
		List<MemberRecentInquiry> recentInquiry = adminMemberDao.findRecentInquiryById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("basicInfo", basicInfo);
		result.put("recentOrder", recentOrder);
		result.put("recentPost", recentPost);
		result.put("recentInquiry", recentInquiry);
		
		return result;
	}
	
	
	@Override
	public Map<String, Object> getMemberInfo(MemberCondition memberCond ) {
		
		/* 전화번호 "-" 제거 */
		memberCond.setCellPhoneNumber(memberCond.getCellPhoneNumber().replace("-", "")); 
		memberCond.setPhoneNumber(memberCond.getPhoneNumber().replace("-", ""));
		
		List<MemberResponse> responseList = adminMemberDao.findByInfo(memberCond);
		
		for ( MemberResponse responseParam : responseList ) {
			
			/* 성별 */
			Character gender = responseParam.getGender().equals('M') ? '남': '여';
			responseParam.setGender(gender);
			
			/* 나이 */
			responseParam.setAge(calculateAge(responseParam));
			
			/* 지역 */
			if(responseParam.getAddress() != null) {
				responseParam.setRegion(detectRegion(responseParam));	
			}
		}
	
		Map<String, Object> result = new HashMap<>();
		result.put("total", responseList.size());
		result.put("memberList", responseList);
		
		return result;
	}
	
	private String detectRegion(MemberResponse param) {
		
		List<String> regions = 
				Arrays.asList("서울","경기","인천","강원","충남", "충청북도","충북","충청북도",
						"대전","경북","경상북도","경남","경상남도","대구","부산","울산",
						"전북","전라북도","전남","전라남도","광주","세종","제주");
		
		String region = "해외";
		for(String value : regions) {
			if(param.getAddress().contains(value)) {
				region = value.length() == 4 
						? value.substring(0, 1) + value.substring(2, 3)
						: value;
				break;
			}
		}
		return region;
	}

	private String calculateAge(MemberResponse param) {
		
		String birth = param.getDateOfBirth().replace("-", "");
		Calendar current = Calendar.getInstance();
		
		int currentYear  = current.get(Calendar.YEAR);
		int currentMonth = current.get(Calendar.MONTH) + 1;
		int currentDay   = current.get(Calendar.DAY_OF_MONTH);
		
		int birthYear = Integer.parseInt(birth.substring(0,4));
		int birthMonth = Integer.parseInt(birth.substring(4,6));
		int birthDay = Integer.parseInt(birth.substring(6,8));
		
		int age = birthMonth * 100 + birthDay > currentMonth * 100 + currentDay 
				? currentYear - birthYear - 1
				: currentYear - birthYear;
		
		return age+"세";
	}
}

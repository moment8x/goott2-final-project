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

@Service
@RequiredArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService {

	private final AdminMemberDAO adminMemberRepository;
	private final MemberCountListener memberCount;
	private final ApplicationEventPublisher publisher;
	
	@Override
	public Map<String, Object> getTotalMemberCount() throws Exception {
		int totalCount = 0;
		if(memberCount.getCurrentCount() > 0) {
			// TotalMemberCountEvent에 저장해둔 값 가져옴
			System.out.println("이벤트 객체에서 전체 회원 수 조회");
			totalCount = memberCount.getCurrentCount(); 
		} else {
			System.out.println("DB에서 전체 회원 수 조회");
			totalCount = adminMemberRepository.countAll();	
			publisher.publishEvent(new TotalMemberCountEvent(totalCount));
		}
		Map<String, Object> result = new HashMap<>();
		result.put("total", totalCount);
		
		return result;
	}
	
	@Override
	public void updateMemberCount() throws Exception {
		int memberCount = adminMemberRepository.countAll();	
		System.out.println("회원 수 갱신");
		// 이벤트 발행
		publisher.publishEvent(new TotalMemberCountEvent(memberCount));
	}	
	
	@Override
	public Map<String, Object> editMemberDetailInfo(MemberParam member) throws Exception {
		
		int result = adminMemberRepository.changeMemberDetailInfo(member);
		Map<String, Object> status = new HashMap<>();
		if(result == 1) {
			status.put("status", "success");
		} else {
			status.put("status", "fail");
		}
		return status;
	}
	
	@Override
	public Map<String, Object> getMemberDetailInfo(String memberId) throws Exception {
		
		MemberParam detailInfo = adminMemberRepository.findDetailInfoById(memberId);
		Map<String, Object> result = new HashMap<>();
		result.put("detailInfo", detailInfo);
		
		return result;
	}
	
	@Override
	public Map<String, Object> getHomeDetailInfo(String memberId) throws Exception {
		
		MemberBasicInfo basicInfo = adminMemberRepository.findBasicInfoById(memberId);
		List<MemberRecentOrder> recentOrder = adminMemberRepository.findRecentOrderById(memberId);
		List<MemberRecentPost> recentPost = adminMemberRepository.findRecentPostById(memberId);
		List<MemberRecentInquiry> recentInquiry = adminMemberRepository.findRecentInquiryById(memberId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("basicInfo", basicInfo);
		result.put("recentOrder", recentOrder);
		result.put("recentPost", recentPost);
		result.put("recentInquiry", recentInquiry);
		
		return result;
	}
	
	
	@Override
	public Map<String, Object> getMemberInfo(MemberCondition memberCond ) throws Exception {
		
		//전화번호 "-" 제거
		memberCond.setCellPhoneNumber(memberCond.getCellPhoneNumber().replace("-", "")); 
		memberCond.setPhoneNumber(memberCond.getPhoneNumber().replace("-", ""));
		
		List<MemberResponse> responseList = adminMemberRepository.findByInfo(memberCond);
		
		for ( MemberResponse responseParam : responseList ) {
			
			//=== 값 세팅 ===//
			
			// 성별
			Character gender = responseParam.getGender().equals('M') ? '남': '여';
			responseParam.setGender(gender);
			
			// 나이
			responseParam.setAge(calculateAge(responseParam));
			
			//지역
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
		for( String value : regions ) {
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

	
//	@EventListener(ContextRefreshedEvent.class)
//	public void updateMemberCount(ContextRefreshedEvent e) throws Exception {
//		
//		// Root WebApplicationContext 초기화 시에만 체크
//		if (e.getApplicationContext().getParent() == null) {
//			int updateCount = adminMemberRepository.countAll();	
//			System.out.println("context refresh");
//			
//			// 전체 회원 수를 조회하는 이벤트 발행
//	        publisher.publishEvent(new TotalMemberCountEvent(updateCount));
//		}
//	}
//	
	


}

package com.project.service.kkb.admin;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminMemberDAO;
import com.project.vodto.kkb.SearchMemberRequest;
import com.project.vodto.kkb.SearchMemberResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService {

	public final AdminMemberDAO adminMemberRepository;
	
	@Override
	public Map<String, Object> getMemberInfo(SearchMemberRequest member) throws Exception {
		
		member.setCellPhoneNumber(member.getCellPhoneNumber().replace("-", "")); 
		member.setPhoneNumber(member.getPhoneNumber().replace("-", ""));
		
		List<SearchMemberRequest> list = adminMemberRepository.findByInfo(member);
		
		List<SearchMemberResponse> responseList = new ArrayList<>();
		for ( SearchMemberRequest param : list ) {
//			System.out.println("param: "+param.toString());
			SearchMemberResponse ResponseParam = new SearchMemberResponse();
			BeanUtils.copyProperties(param, ResponseParam, new String[] {"email", "dateOfBirth", "address", "detailedAddress", "registrationDate"});
			
			//가입일
			ResponseParam.setRegistrationDate(param.getRegistrationDate().toString());
			
			// 성별
			Character gender = param.getGender().equals('M') ? '남': '여';
			ResponseParam.setGender(gender);
			
			//나이
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
	        
			ResponseParam.setAge(age+"세");
			
			//지역
			String[] region = 
					new String[] {"서울","경기","인천","강원","충남","충북","대전","경북","경남","대구","부산","울산","전북","전남","광주","세종","제주"}; 
			
			for( String value : region ) {
				if(param.getAddress().contains(value)) {
					ResponseParam.setRegion(value);
					break;
				} else {
					ResponseParam.setRegion("해외");
				}
			}
			
//			System.out.println("ResponseParam: "+ResponseParam);
			responseList.add(ResponseParam);
		}
	
		Map<String, Object> result = new HashMap<>();
		result.put("memberList", responseList);
		
		return result;
	}

}

package com.project.service.kkb.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminInquiryDAO;
import com.project.vodto.kkb.InquiryCondition;
import com.project.vodto.kkb.InquiryResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminInquiryServiceImpl implements AdminInquiryService {
	
	private final AdminInquiryDAO adminInquiryDao;
	
	/* 1:1 문의 조회 */
	@Override
	public Map<String, Object> getInquiryInfo(InquiryCondition inquiryCond) {
		
		List<InquiryResponse> inquiryList = adminInquiryDao.findInquiryByInfo(inquiryCond);
	
		Map<String, Object> result = new HashMap<>();
		result.put("inquiryList", inquiryList);
		
		return result;
	}

}

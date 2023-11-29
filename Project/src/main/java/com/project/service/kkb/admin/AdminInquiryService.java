package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.InquiryCondition;

public interface AdminInquiryService {

	/* 1:1 문의 조회 */
	Map<String, Object> getInquiryInfo(InquiryCondition inquiryCond);

}

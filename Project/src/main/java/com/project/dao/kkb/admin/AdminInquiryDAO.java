package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.InquiryCondition;
import com.project.vodto.kkb.InquiryResponse;

public interface AdminInquiryDAO {
	
	/* 1:1 문의 조회 */
	List<InquiryResponse> findInquiryByInfo(InquiryCondition inquiryCond);

}

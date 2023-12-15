package com.project.dao.kkb.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.InquiryCondition;
import com.project.vodto.kkb.InquiryResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminInquiryDAOImpl implements AdminInquiryDAO {

	private static String ns = "com.project.mappers.adminInquiryMapper";
	private final SqlSession ses;
	
	@Override
	public List<InquiryResponse> findInquiryByInfo(InquiryCondition inquiryCond) {
		return ses.selectList(ns + ".selectInquiryInfo",inquiryCond);
	}

}

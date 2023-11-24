package com.project.dao.ksh.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.CustomerInquiry;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;

@Repository
public class InquiryDAOImpl implements InquiryDAO {
	
	@Inject SqlSession ses; // db랑 연결해줌

	private static String ns = "com.ksh.mappers.InquiryMapper";


	@Override
	public CustomerInquiry saveInquiry(CustomerInquiry inquiry) throws Exception {
		// 문의 저장
		ses.insert(ns+".saveInquiry", inquiry);
		
		return inquiry;
	}


	@Override
	public int insertUploadImage(UploadFiles file) throws Exception {
		// upload_files table 저장
		ses.insert(ns+".uploadImages", file);
		return file.getUploadFilesSeq();
	}

	@Override
	public int insertInquiryFile(InquiryFile inquiryFile) throws Exception {
		// customer_inquiry_uf 저장
		return ses.insert(ns+".insertInquiryFile", inquiryFile);
	}


	@Override
	public List<CustomerInquiry> getInquiries(String memberId) throws Exception {
		// 문의 내역 가져오기
		return ses.selectList(ns+".getInquiries", memberId);
	}


	@Override
	public CustomerInquiryDTO getDetailInquiry(String memberId, int postNo) throws Exception {
		// 상세 문의 내역 가져오기
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("postNo", postNo);
		return ses.selectOne(ns+".getDetailInquiry", params);
	}


	@Override
	public List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception {
		// 문의에 첨부된 이미지 가져오기
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("author", author);
		params.put("postNo", postNo);
		return ses.selectList(ns+".getInquiryFiles", params);
	}


	@Override
	public int checkValidation(int postNo, String memberId) {
		// 수정하려는 사람과 글의 작성자가 일치하는지
		Map<String, Object> params = new HashMap<String, Object>();
		postNo = 11;
		params.put("author", memberId);
		params.put("postNo", postNo);
		return ses.selectOne(ns+".checkValidation", params);
		
	}


	

}

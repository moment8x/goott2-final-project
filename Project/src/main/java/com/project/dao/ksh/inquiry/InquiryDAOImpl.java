package com.project.dao.ksh.inquiry;

import java.util.ArrayList;
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
import com.project.vodto.ksh.PagingInfo;
import com.project.vodto.ksh.UploadFilesDTO;

@Repository
public class InquiryDAOImpl implements InquiryDAO {
	
	@Inject SqlSession ses; // db랑 연결해줌

	private static String ns = "com.ksh.mappers.InquiryMapper";


	@Override
	public CustomerInquiryDTO saveInquiry(CustomerInquiryDTO inquiry) throws Exception {
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
	public List<CustomerInquiry> getInquiries(String memberId, PagingInfo pi) throws Exception {
		// 문의 내역 가져오기
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("pi", pi);
		return ses.selectList(ns+".getInquiries", params);
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
		params.put("author", memberId);
		params.put("postNo", postNo);
		return ses.selectOne(ns+".checkValidation", params);
		
	}


	@Override
	public int deleteFiles(List<UploadFiles> deleteFiles) throws Exception {
		// 수정 시 기존 이미지 삭제했다면 디비에도 삭제해줘야함
		int i = 0;
		for(UploadFiles uf : deleteFiles) {
			i += ses.delete(ns+".deleteFiles", uf.getNewFileName());
		}
		System.out.println("지웠다 드디어" + i);
		return i;
	}


	@Override
	public int updateInquiry(CustomerInquiryDTO inquiry) throws Exception {
		// 문의 업데이트
		return ses.update(ns+".updateInquiry", inquiry);
	}


	@Override
	public int deleteInquiry(CustomerInquiryDTO inquiry) throws Exception {
		// 답변 전 문의 글 삭제
		
		return ses.delete(ns+".deleteInquiry", inquiry);
	}

	@Override
	public int getTotalPostCnt(String memberId) throws Exception {
		return ses.selectOne(ns+".getInquiryCnt", memberId);
	}
	

}

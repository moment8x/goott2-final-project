package com.project.service.ksh.inquiry;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.ksh.inquiry.InquiryDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;

@Service
public class InquiryServiceImpl implements InquiryService {
	
	@Inject private InquiryDAO inquiryDao;

	@Override
	public int saveInquiry(CustomerInquiry inquiry, List<UploadFiles> fileList) throws Exception {
		// 문의 저장
		int result = 0;
		if(fileList.size()>0) {
			// 파일이 한 개라도 있을 때
			inquiry = inquiryDao.saveInquiry(inquiry);
			for (UploadFiles file : fileList) {
				if (ImgMimeType.extIsImage(file.getExtension())) {
					int uploadFilesSeq = inquiryDao.insertUploadImage(file);
					System.out.println("uploadFilesSeq : " + uploadFilesSeq);
					if (uploadFilesSeq > 0) {
						// 3) insert 성공 시 board_uf 테이블에도 insert
						InquiryFile inquiryFile = new InquiryFile();
						inquiryFile.setPostNo(inquiry.getPostNo());
						inquiryFile.setUploadFilesSeq(uploadFilesSeq);
						if(inquiryDao.insertInquiryFile(inquiryFile) > 0) {
							System.out.println("문의랑 파일까지 모두 성공!");
							result = 1;
						};
					}
				}
			}
		} else {
			// 파일이 없을 때
			if(inquiryDao.saveInquiry(inquiry).getPostNo() > 0) {
				System.out.println("파일 없이 문의만 작성 성공!");
				result=1;
			};
		}
		return result;
		
	}

	@Override
	public List<CustomerInquiry> getInquiries(String memberId) throws Exception {
		// 문의 내역
		List<CustomerInquiry> myInquiries = inquiryDao.getInquiries(memberId);
		return myInquiries;
	}

	@Override
	public CustomerInquiryDTO viewDetailInquiry(String memberId, int postNo) throws Exception {
		// 상세 문의 내역 가져오기
		
		return inquiryDao.getDetailInquiry(memberId, postNo);
	}

	@Override
	public List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception {
		// 문의에 함께 첨부된 이미지 가져오기
		return inquiryDao.getInquiryFiles(author, postNo);
	}

	@Override
	public int checkValidation(int postNo, String memberId) {
		// 수정하려는 사람과 글의 작성자가 일치하는지
		return inquiryDao.checkValidation(postNo, memberId);
		
	}

	@Override
	public int updateInquiry(CustomerInquiry inquiry, List<UploadFiles> fileList) {
		// 문의 수정
		
		return 0;
	}

	
}

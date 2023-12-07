package com.project.dao.ksh.inquiry;

import java.util.List;

import com.project.vodto.CustomerInquiry;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;
import com.project.vodto.ksh.PagingInfo;
import com.project.vodto.ksh.UploadFilesDTO;

public interface InquiryDAO {

	CustomerInquiryDTO saveInquiry(CustomerInquiryDTO inquiry) throws Exception;

	int insertUploadImage(UploadFiles file) throws Exception;

	int insertInquiryFile(InquiryFile inquiryFile) throws Exception;

	List<CustomerInquiry> getInquiries(String memberId, PagingInfo pi) throws Exception;

	CustomerInquiryDTO getDetailInquiry(String memberId, int postNo) throws Exception;

	List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception;

	int checkValidation(int postNo, String memberId) throws Exception;

	int deleteFiles(List<UploadFiles> deleteFiles) throws Exception;

	int updateInquiry(CustomerInquiryDTO inquiry) throws Exception;

	int deleteInquiry(CustomerInquiryDTO inquiry) throws Exception;
	
	int getTotalPostCnt(String memberId) throws Exception;

}

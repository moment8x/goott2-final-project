package com.project.service.ksh.inquiry;

import java.util.List;

import com.project.vodto.CustomerInquiry;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;

public interface InquiryService {

	int saveInquiry(CustomerInquiry inquiry, List<UploadFiles> fileList) throws Exception;

	List<CustomerInquiry> getInquiries(String memberId) throws Exception;

	CustomerInquiryDTO viewDetailInquiry(String memberId, int postNo) throws Exception;

	List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception;

	int checkValidation(int postNo, String memberId);

	int updateInquiry(CustomerInquiry inquiry, List<UploadFiles> fileList);

	

}

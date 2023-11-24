package com.project.dao.ksh.inquiry;

import java.util.List;

import com.project.vodto.CustomerInquiry;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;

public interface InquiryDAO {

	CustomerInquiry saveInquiry(CustomerInquiry inquiry) throws Exception;

	int insertUploadImage(UploadFiles file) throws Exception;

	int insertInquiryFile(InquiryFile inquiryFile) throws Exception;

	List<CustomerInquiry> getInquiries(String memberId) throws Exception;

	CustomerInquiryDTO getDetailInquiry(String memberId, int postNo) throws Exception;

	List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception;

	int checkValidation(int postNo, String memberId);

}

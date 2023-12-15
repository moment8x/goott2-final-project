package com.project.service.ksh.inquiry;

import java.util.List;
import java.util.Map;

import com.project.vodto.CustomerInquiry;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;

public interface InquiryService {

	int saveInquiry(CustomerInquiryDTO inquiry, List<UploadFiles> fileList) throws Exception;

	Map<String, Object> getInquiries(String memberId, int pageNo) throws Exception;

	CustomerInquiryDTO viewDetailInquiry(String memberId, int postNo) throws Exception;

	List<UploadFiles> getInquiryFiles(String author, int postNo) throws Exception;

	int checkValidation(int postNo, String memberId) throws Exception;

	int updateInquiry(CustomerInquiryDTO inquiry, List<UploadFiles> deleteFileList,List<UploadFiles> fileList) throws Exception;

	int deleteInquiry(int postNo, String memberId, String realPath) throws Exception;

	

}

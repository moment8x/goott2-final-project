package com.project.service.ksh.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.ksh.inquiry.InquiryDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.service.kjs.upload.UploadFileService;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;
import com.project.vodto.ksh.CustomerInquiryDTO;
import com.project.vodto.ksh.PagingInfo;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Inject
	UploadFileService ufService;
	
	@Inject
	private InquiryDAO inquiryDao;

	@Override
	public int saveInquiry(CustomerInquiryDTO inquiry, List<UploadFiles> fileList) throws Exception {
		// 문의 저장
		int result = 0;
		if(inquiry.getInquirySms().equals("sms")) {
			inquiry.setInquirySms("Y");
		} else {
			inquiry.setInquirySms("N");			
		}
		inquiry.setContent(inquiry.getContent().replace("\r\n", "<br />"));
		if (fileList.size() > 0) {
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
						if (inquiryDao.insertInquiryFile(inquiryFile) > 0) {
							System.out.println("문의랑 파일까지 모두 성공!");
							result = 1;
						}
						;
					}
				}
			}
		} else {
			// 파일이 없을 때
			if (inquiryDao.saveInquiry(inquiry).getPostNo() > 0) {
				System.out.println("파일 없이 문의만 작성 성공!");
				result = 1;
			}
			;
		}
		return result;

	}

	@Override
	public Map<String, Object> getInquiries(String memberId, int pageNo) throws Exception {
		// 문의 내역
		PagingInfo pi = makePagingInfo(pageNo, memberId);
		List<CustomerInquiry> myInquiries = inquiryDao.getInquiries(memberId,pi);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("myInquiries", myInquiries);
		result.put("pagingInfo", pi);
		return result;
		
	}
	
	private PagingInfo makePagingInfo(int pageNo, String memberId) throws Exception {
		PagingInfo result = new PagingInfo();
		
		// 현재 페이지 번호 세팅
		result.setPageNo(pageNo);
		// 전체 글의 갯수
		result.setTotalPostCnt(inquiryDao.getTotalPostCnt(memberId));
		
		// 총 페이지 수 구하기
		result.setTotalPageCnt(result.getTotalPostCnt(), result.getViewPostCntPerPage());
		
		// 보여주기 시작할 row index 번호 구하기
		result.setStartRowIndex();
		
		// --------------------------------------------------
		// 몇 개의 페이징 블럭이 나오는지...
		result.setTotalPagingBlockCnt();
		
		// 현재 페이지가 속한 페이징 블럭 번호
		result.setPageBlockOfCurrentPage();
		
		// 현재 블럭의 시작 페이지 번호 구하기
		result.setStartNumOfCurrentPagingBlock();
		
		// 현재 블럭의 끝 페이지 번호 구하기
		result.setEndNumOfCurrentPagingBlock();
		
		return result;
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
	public int checkValidation(int postNo, String memberId) throws Exception {
		// 수정하려는 사람과 글의 작성자가 일치하는지
		return inquiryDao.checkValidation(postNo, memberId);

	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateInquiry(CustomerInquiryDTO inquiry, List<UploadFiles> deleteFileList, List<UploadFiles> fileList)
			throws Exception {
		// 문의 수정
		int result = 0;
		inquiry.setContent(inquiry.getContent().replace("\r\n", "<br />"));
		List<UploadFiles> existingFiles;

		if(inquiry.getInquirySms().equals("sms")) {
			inquiry.setInquirySms("Y");
		} else {
			inquiry.setInquirySms("N");			
		}
		existingFiles = inquiryDao.getInquiryFiles(inquiry.getAuthor(), inquiry.getPostNo());
		System.out.println("수정하려는데 기존 파일 알아오기! " + existingFiles.toString());
		System.out.println("fileList 일치하나 보자! " + fileList.toString());
		result = inquiryDao.updateInquiry(inquiry);
		if (result > 0) {
			System.out.println("문의는 성공임");

			// 파일이 있을 때
			if (existingFiles.get(0).getUploadFilesSeq() > 0) {
				if (deleteFileList.size() > 0) {
					if (inquiryDao.deleteFiles(deleteFileList) > 0) {
						System.out.println("삭제 성공!" + deleteFileList.toString());
						result = 1;
					} else {
						result = -1;
					}
				}
				if (fileList.size() > 0) {
					for (UploadFiles file : fileList) {
						if (ImgMimeType.extIsImage(file.getExtension())) {
							int uploadFilesSeq = inquiryDao.insertUploadImage(file);
							System.out.println("uploadFilesSeq : " + uploadFilesSeq);
							if (uploadFilesSeq > 0) {
								// 3) insert 성공 시 board_uf 테이블에도 insert
								InquiryFile inquiryFile = new InquiryFile();
								inquiryFile.setPostNo(inquiry.getPostNo());
								inquiryFile.setUploadFilesSeq(uploadFilesSeq);
								if (inquiryDao.insertInquiryFile(inquiryFile) > 0) {
									System.out.println("수정 시 파일이 있을 때 새 파일 insert 성공!");
									result = 1;
								} else {
									result = -1;
								}
								;
							}
						}
					}
				}
			} else { // 파일이 없을 때
				// 파일이 없는데 파일을 추가하려 할 때
				if (fileList.size() > 0) {
					for (UploadFiles file : fileList) {
						if (ImgMimeType.extIsImage(file.getExtension())) {
							int uploadFilesSeq = inquiryDao.insertUploadImage(file);
							System.out.println("uploadFilesSeq : " + uploadFilesSeq);
							if (uploadFilesSeq > 0) {
								// 3) insert 성공 시 board_uf 테이블에도 insert
								InquiryFile inquiryFile = new InquiryFile();
								inquiryFile.setPostNo(inquiry.getPostNo());
								inquiryFile.setUploadFilesSeq(uploadFilesSeq);
								if (inquiryDao.insertInquiryFile(inquiryFile) > 0) {
									System.out.println("수정 시 파일이 없을때  파일 저장 성공!");
									result = 1;
								} else {
									result = -1;
								}
								;
							}
						}
					}
				}
			}
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteInquiry(int postNo, String memberId, String realPath) throws Exception {
		int result = 0;

		CustomerInquiryDTO detailInquiry = inquiryDao.getDetailInquiry(memberId, postNo);
		// 답변 전인 문의 글 삭제

		if (detailInquiry.getAnswerStatus() != "y") {	// 답변 전 문의글만 삭제하기 때문에
			if (detailInquiry.getUploadFilesSeq() > 0) { // 파일 있을 때
				List<UploadFiles> uploadFiles = inquiryDao.getInquiryFiles(memberId, postNo);
				if (uploadFiles.get(0).getUploadFilesSeq() > 0) {	// 파일 리스트 받아오기
					for (UploadFiles file : uploadFiles) {
						ufService.deleteFile(file, realPath);
					}
					
					if (inquiryDao.deleteFiles(uploadFiles) > 0) {	// 파일 삭제
						if(inquiryDao.deleteInquiry(detailInquiry) > 0) { // 문의 글 삭제
							System.out.println("파일 있는 문의 글 삭제 완료");
							result = 1;
						}
					}
				} 
			} else {
				// 파일 없을 때 문의 글만 삭제
				if(inquiryDao.deleteInquiry(detailInquiry) > 0) {
					System.out.println("파일 없는 문의 글 삭제 완료");
					result = 1;
				}
			}
		} else {	// 답변완료 된 문의 글
			System.out.println("답변 완료 된 문의글은 삭제할 수 없습니다.");
		}
		return result;

	}

}

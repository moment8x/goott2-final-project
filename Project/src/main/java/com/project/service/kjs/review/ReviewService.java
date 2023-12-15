package com.project.service.kjs.review;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ReviewBoardDTO;


public interface ReviewService {
	// 리뷰 등록
	boolean saveReview(ReviewBoard review, List<UploadFiles> fileList) throws SQLException, NamingException;
	// 해당 제품에 리뷰를 쓸 권한(배송완료 상태, 리뷰 작성X)
	boolean haveARecord(String memberId, String productId) throws SQLException, NamingException;
	// 리뷰 목록 조회
	Map<String, Object> getReviewList(String productId, int page) throws SQLException, NamingException;
	// 리뷰 수정을 위한 데이터 조회
	ReviewBoardDTO getReview(int postNo, String memberId) throws SQLException, NamingException;
	// 리뷰 수정
	boolean updateReview(int postNo, String content, int rating, List<UploadFiles> fileList, List<String> deleteFileList, String realPath, String productId) throws SQLException, NamingException;
	// 삭제할 권한 확인
	boolean deleteCheck(int postNo, String memberId, String productId) throws SQLException, NamingException;
	// 리뷰 삭제
	boolean deleteReview(int postNo) throws SQLException, NamingException;
}
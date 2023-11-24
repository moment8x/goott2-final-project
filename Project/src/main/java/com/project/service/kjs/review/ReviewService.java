package com.project.service.kjs.review;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;


public interface ReviewService {
	// 리뷰 등록
	boolean saveReview(ReviewBoard review, List<UploadFiles> fileList) throws SQLException, NamingException;
	// 해당 제품에 리뷰를 쓸 권한(배송완료 상태, 리뷰 작성X)
	boolean haveARecord(String memberId, String productId) throws SQLException, NamingException;
}
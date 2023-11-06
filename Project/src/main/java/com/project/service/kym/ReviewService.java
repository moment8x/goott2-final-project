package com.project.service.kym;

import java.util.List;

import com.project.vodto.Board;

public interface ReviewService {

	// 모든 리뷰 가져오기
	List<Board> getAllReview(String subcategory) throws Exception;

	// 리뷰 저장
	public boolean saveReview(Board newReview) throws Exception;

	// 리뷰 업데이트
	public boolean updateReview(Board updateReview) throws Exception;

	// 리뷰 삭제
	public boolean deleteReview(Board deleteReview) throws Exception;
}

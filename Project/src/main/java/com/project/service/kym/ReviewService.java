package com.project.service.kym;


import java.util.List;


import com.project.vodto.Board;



public interface ReviewService {
	

	// 모든 댓글 가져오기
		List<Board> getAllReview(String subcategory) throws Exception;
		
		// 신규 댓글 저장
		boolean saveReview(Board review) throws Exception;
}

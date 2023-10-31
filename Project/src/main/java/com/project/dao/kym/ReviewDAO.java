package com.project.dao.kym;


import java.util.List;

import com.project.vodto.Board;

public interface ReviewDAO {
	// 해당책의 모든 리뷰 가져오기
	List<Board> selectAllReview(String subcategory) throws Exception;
	
	// 신규 리뷰 저장
	int insertReview(Board board) throws Exception;
	}

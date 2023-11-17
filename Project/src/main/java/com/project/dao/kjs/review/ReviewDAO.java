package com.project.dao.kjs.review;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.ReviewBoard;

public interface ReviewDAO {
	// 리뷰 게시글 저장
	int insertReview(ReviewBoard review) throws SQLException, NamingException;
	// 방금 저장한 게시글 번호 가져오기
	Integer getBoardNo(String author) throws SQLException, NamingException;
	// 물품 구매 이력 및 배송 상태 조회
	List<String> getPruchaseRecord(String memberId, String productId) throws SQLException, NamingException;
	// 해당 물품 리뷰 작성 기록 조획
	List<String> isExists(String memberId, String productId) throws SQLException, NamingException;
	// 포인트 법칙에 적용된 포인트 조회
	Integer getPointRule(String reason) throws SQLException, NamingException;
	// 리뷰 작성 시 point_logs 테이블에 기록
	int insertPointLog(String memberId, int point) throws SQLException, NamingException;
	// point_logs에 성공적으로 insert 시 member에도 update
	int updatePoint(String memberId, int point) throws SQLException, NamingException;
}
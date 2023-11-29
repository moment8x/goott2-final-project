package com.project.dao.kjs.review;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.PagingInfo;
import com.project.vodto.Ratings;
import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ReviewBoardDTO;

public interface ReviewDAO {
	// 리뷰 게시글 저장
	int insertReview(ReviewBoard review) throws SQLException, NamingException;
	// 방금 저장한 게시글 번호 가져오기
	Integer getBoardNo(String author) throws SQLException, NamingException;
	// 물품 구매 이력 및 배송 상태 조회
	List<String> getPruchaseRecord(String memberId, String productId) throws SQLException, NamingException;
	// 해당 물품 리뷰 작성 기록 조회
	int isExists(String memberId, String productId) throws SQLException, NamingException;
	// 포인트 법칙에 적용된 포인트 조회
	Integer getPointRule(String reason) throws SQLException, NamingException;
	// 리뷰 작성 시 point_logs 테이블에 기록
	int insertPointLog(String memberId, int point) throws SQLException, NamingException;
	// point_logs에 성공적으로 insert 시 member에도 update
	int updatePoint(String memberId, int point) throws SQLException, NamingException;
	// 리뷰 전체 글 개수 조회
	int selectProductCount(String key) throws SQLException, NamingException;
	// 상품의 리뷰 게시글 목록 조회
	List<ReviewBoardDTO> getReviewList(String productId, PagingInfo pagingInfo) throws SQLException, NamingException;
	// 리뷰 게시글 이미지 개수 조회
	int getCountImages(int postNo) throws SQLException, NamingException;
	// 리뷰 게시글 이미지 조회
	List<String> getImagesAddr(int postNo) throws SQLException, NamingException;
	// 리뷰 게시글 이미지 조회
	List<UploadFiles> getImages(int postNo) throws SQLException, NamingException;
	// 리뷰 글 조회
	ReviewBoardDTO getReview(int postNo) throws SQLException, NamingException;
	// 최대 리뷰 글 번호 조회
	int getMaxPostNo() throws SQLException, NamingException;
	// 리뷰 작성 시 rating 테이블에 넣을 값을 연산하기 위해 review_board 테이블 데이터 가져오기
	Ratings getCalcRatingData(String productId) throws SQLException, NamingException;
	// ratings 테이블에 값을 insert
	int insertRatings(Ratings ratings) throws SQLException, NamingException;
	// 리뷰 수정
	int updateReview(int postNo, String content, int rating) throws SQLException, NamingException;
	// 리뷰 작성이 최초인가 확인
	int firstCheck(String memberId, String productId) throws SQLException, NamingException;
	// 리뷰 삭제 검사 - 넘어온 정보(id, postNo, productId)와 DB의 값이 같은 것이 존재하는가
	int deleteCheck(int postNo, String memberId, String productId) throws SQLException, NamingException;
	// 리뷰 삭제
	int deleteReview(int postNo) throws SQLException, NamingException;
	// ratings 테이블 업데이트
	int updateRatings(Ratings ratings) throws SQLException, NamingException;
	
}
package com.project.dao.kjs.review;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ReviewBoard;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	SqlSession session;
	
	String ns = "com.project.mappers.reviewMapper";
	
	@Override
	public int insertReview(ReviewBoard review) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - 리뷰 등록 =======");
		return session.insert(ns + ".insertReview", review);
	}

	@Override
	public Integer getBoardNo(String author) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - 리뷰글 번호 가져오기 =======");
		return session.selectOne(ns + ".getReviewNo", author);
	}

	@Override
	public List<String> getPruchaseRecord(String memberId, String productId) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - 물품 구매 이력 가져오기 =======");
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		
		return session.selectList(ns + ".getPruchaseRecord", params);
	}

	@Override
	public List<String> isExists(String memberId, String productId) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - 물품 리뷰 작성 기록 가져오기 =======");
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		
		return session.selectList(ns + ".isExists", params);
	}

	@Override
	public int insertPointLog(String memberId, int point) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - point_logs 테이블에 insert =======");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("point", point);
		
		return session.insert(ns + ".insertPointLog", memberId);
	}
	
	@Override
	public Integer getPointRule(String reason) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - point_rules에서 point 조회 =======");
		return session.selectOne(ns + ".getPointRule", reason);
	}

	@Override
	public int updatePoint(String memberId, int point) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 DAO - member 테이블에 update =======");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("point", point);
		
		return session.update(ns + ".updatePoint", params);
	}
}
package com.project.dao.kjs.review;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.PagingInfo;
import com.project.vodto.Ratings;
import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ReviewBoardDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Inject
	SqlSession session;
	
	String ns = "com.project.mappers.reviewMapper";
	
	@Override
	public int insertReview(ReviewBoard review) throws SQLException, NamingException {
		review.setContent(review.getContent().replace("\r\n", "<br/>"));
		return session.insert(ns + ".insertReview", review);
	}

	@Override
	public Integer getBoardNo(String author) throws SQLException, NamingException {
		return session.selectOne(ns + ".getReviewNo", author);
	}

	@Override
	public List<String> getPruchaseRecord(String memberId, String productId) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		return session.selectList(ns + ".getPurchaseRecord", params);
	}

	@Override
	public int isExists(String memberId, String productId) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		
		return session.selectOne(ns + ".isExists", params);
	}

	@Override
	public int insertPointLog(String memberId, int point) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("point", point);
		
		return session.insert(ns + ".insertPointLog", params);
	}
	
	@Override
	public Integer getPointRule(String reason) throws SQLException, NamingException {
		return session.selectOne(ns + ".getPointRule", reason);
	}

	@Override
	public int updatePoint(String memberId, int point) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("point", point);
		
		return session.update(ns + ".updatePoint", params);
	}

	@Override
	public int selectProductCount(String key) throws SQLException, NamingException {
		return session.selectOne(ns + ".selectProductCount", key);
	}

	@Override
	public List<ReviewBoardDTO> getReviewList(String productId, PagingInfo pagingInfo) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		params.put("startRowIndex", pagingInfo.getStartRowIndex());
		params.put("viewProductPerPage", pagingInfo.getViewProductPerPage());
		
		return session.selectList(ns + ".getReviewList", params);
	}

	@Override
	public int getCountImages(int postNo) throws SQLException, NamingException {
		return session.selectOne(ns + ".getCountImages", postNo);
	}

	@Override
	public List<String> getImagesAddr(int postNo) throws SQLException, NamingException {
		return session.selectList(ns + ".getImagesAddr", postNo);
	}
	
	@Override
	public List<UploadFiles> getImages(int postNo) throws SQLException, NamingException {
		return session.selectList(ns + ".getImages", postNo);
	}

	@Override
	public ReviewBoardDTO getReview(int postNo) throws SQLException, NamingException {
		return session.selectOne(ns + ".getReview", postNo);
	}

	@Override
	public int getMaxPostNo() throws SQLException, NamingException {
		return session.selectOne(ns + ".getMaxPostNo");
	}

	@Override
	public Ratings getCalcRatingData(String productId) throws SQLException, NamingException {
		return session.selectOne(ns + ".getCalcRatingData", productId);
	}

	@Override
	public int insertRatings(Ratings rating) throws SQLException, NamingException {
		return session.insert(ns + ".insertRatings", rating);
	}

	@Override
	public int updateReview(int postNo, String content, int rating) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("postNo", postNo);
		params.put("content", content);
		params.put("rating", rating);
		
		return session.update(ns + ".updateReview", params);
	}

	@Override
	public int firstCheck(String memberId, String productId) throws SQLException, NamingException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("memberId", memberId);
		params.put("productId", productId);
		return session.selectOne(ns + ".firstCheck", params);
	}

	@Override
	public int deleteCheck(int postNo, String memberId, String productId) throws SQLException, NamingException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("postNo", postNo);
		params.put("memberId", memberId);
		params.put("productId", productId);
		return session.selectOne(ns + ".deleteCheck", params);
	}

	@Override
	public int deleteReview(int postNo) throws SQLException, NamingException {
		return session.update(ns + ".deleteReview", postNo);
	}

	@Override
	public int updateRatings(Ratings ratings) throws SQLException, NamingException {
		return session.update(ns + ".updateRatings", ratings);
	}
}
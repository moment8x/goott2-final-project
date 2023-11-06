package com.project.dao.kym;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Board;
import com.project.vodto.Product;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.kym.mappers.reviewMapper";

	@Override
	public List<Board> selectAllReview(String subcategory) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".getAllReview", subcategory);
	}

	@Override
	public int insertReview(Board board) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertReview", board);
	}

	@Override
	public int updateReview(Board board) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".updateReview", board);
	}

	@Override
	public int deleteReview(Board board) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns + ".updateReview", board);
	}

}

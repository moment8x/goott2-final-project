package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ReviewUf;

@Repository
public class ReviewUploadDAOImpl implements ReviewUploadDAO {
	
	@Inject
	SqlSession session;
	
	String ns = "com.kym.mappers.reviewUploadMapper";
	
	@Override
	public int insertImage(ReviewUf reviewUf) throws SQLException, NamingException {
		System.out.println("======= 리뷰 게시판 파일 업로드 DAO - 게시판 파일 정보 저장 =======");
		
		return session.insert(ns + ".insertImage", reviewUf);
	}
}
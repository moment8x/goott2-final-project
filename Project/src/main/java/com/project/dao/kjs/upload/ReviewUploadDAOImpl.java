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
		return session.insert(ns + ".insertImage", reviewUf);
	}

	@Override
	public int deleteImage(int uploadFilesSeq) throws SQLException, NamingException {
		return session.delete(ns + ".deleteImage", uploadFilesSeq);
	}
}
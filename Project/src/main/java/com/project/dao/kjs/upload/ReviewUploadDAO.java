package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.ReviewUf;

public interface ReviewUploadDAO {
	// 리뷰게시판의 파일 정보 insert
	int insertImage(ReviewUf reviewUf) throws SQLException, NamingException;
	// 리뷰게시판의 파일 정보 delete
	int deleteImage(int uploadFilesSeq) throws SQLException, NamingException;
}
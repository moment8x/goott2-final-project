package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.UploadFiles;

public interface UploadDAO {
	// 파일 DB에 저장
	int insertUploadImage(UploadFiles file) throws SQLException, NamingException;
	// DB에 있는 new_file_name로 검색해서 나온 uploadFiles 테이블의 key값
	Integer selectUploadFile(String newFileName) throws SQLException, NamingException;
	// DB에 있는 파일 정보 삭제
	int deleteUploadFile(int uploadFilesSeq) throws SQLException, NamingException;
}
package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;

import com.project.vodto.UploadFile;

public class UploadDAOImpl implements UploadDAO {

	@Inject
	SqlSession session;
	
	String ns = "com.project.mappers.uploadFileMapper";
	
	@Override
	public int insertUploadFile(UploadFile file) throws SQLException, NamingException {
		System.out.println("======= 파일 업로드 DAO - insert file upload =======");
		
		return session.insert(ns + ".insertFile", file);
	}

}

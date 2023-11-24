package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.UploadFiles;

@Repository
public class UploadDAOImpl implements UploadDAO {

	@Inject
	SqlSession session;
	
	String ns = "com.project.mappers.uploadFileMapper";
	
	@Override
	public int insertUploadImage(UploadFiles file) throws SQLException, NamingException {
		System.out.println("======= 파일 업로드 DAO - insert file upload =======");
		
		return session.insert(ns + ".insertImage", file);
	}

	@Override
	public Integer selectUploadFile(UploadFiles file) throws SQLException, NamingException {
		System.out.println("======= 파일 업로드 DAO - select file upload =======");
		
//		file.setNewFileName(file.getNewFileName().replace("\\", "/"));
		
		return session.selectOne(ns + ".isExist", file);
	}
}

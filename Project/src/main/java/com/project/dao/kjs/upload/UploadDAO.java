package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.UploadFile;

public interface UploadDAO {
	int insertUploadFile(UploadFile file) throws SQLException, NamingException;
}
package com.project.dao.kjs.upload;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.project.vodto.UploadFiles;

public interface UploadDAO {
	int insertUploadFile(UploadFiles file) throws SQLException, NamingException;
	Integer selectUploadFile(UploadFiles file) throws SQLException, NamingException;
}
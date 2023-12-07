package com.project.service.kjs.upload;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.project.vodto.UploadFiles;

public interface UploadFileService {
	// 실제 파일 업로드
	UploadFiles uploadFile(String originalFileName, long size, String contentType, byte[] data, String realPath) throws IOException;
	// 실제 파일 삭제
	int deleteFile(String newFileName, String realPath);
	// 기존 파일이 DB에 존재하는지 확인
	boolean isExist(String newFileName) throws SQLException, NamingException;
	// 특정 파일 삭제
	void deleteUploadedFile(List<String> deleteFileList, String realPath) throws IOException;
	
	// 상희
	 int deleteFile(UploadFiles uf, String realPath);
}
package com.project.service.kjs.upload;

import java.io.IOException;

import com.project.vodto.UploadFile;

public interface UploadFileService {
	UploadFile uploadFile(String originalFileName, long size, String contentType, byte[] data,
			String realPath) throws IOException;
}
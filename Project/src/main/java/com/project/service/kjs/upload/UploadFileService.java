package com.project.service.kjs.upload;

import java.io.IOException;

import com.project.vodto.UploadFile;

public interface UploadFileService {
	UploadFile uploadFile(UploadFile uf) throws IOException;
}
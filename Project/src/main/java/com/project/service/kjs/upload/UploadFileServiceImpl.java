package com.project.service.kjs.upload;

import java.io.IOException;

import org.springframework.stereotype.Service;

import com.project.vodto.UploadFile;

@Service
public class UploadFileServiceImpl implements UploadFileService {

	@Override
	public UploadFile uploadFile(UploadFile uf) throws IOException {
		System.out.println("======= 업로드 서비스단 - 업로드 파일 =======");
		UploadFile result = null;
		
		
		
		System.out.println("======= 업로드 서비스단 종료 =======");
		return result;
	}
}
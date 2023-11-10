package com.project.service.kjs.upload;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.project.dao.kjs.upload.UploadDAO;
import com.project.vodto.UploadFiles;

@Service
public class UploadFileServiceImpl implements UploadFileService {

	@Inject
	UploadDAO uDao;
	
	@Override
	public UploadFiles uploadFile(String originalFileName, long size, String contentType, byte[] data,
			String realPath) throws IOException {
		System.out.println("======= 업로드 서비스단 - 업로드 파일 =======");
		
		String completePath = makeCalculatePath(realPath);	// 물리적 경로 + /년/월/일
		System.out.println("completePath : " + completePath);
		UploadFiles uf = new UploadFiles();
		
		if (size > 0) {
			uf.setOriginalFileName(originalFileName);
			uf.setFileSize(size);
			uf.setNewFileName(getNewFileName(originalFileName, realPath, completePath));
			uf.setExtension(originalFileName.substring(originalFileName.lastIndexOf(".") + 1));
			
			// 실제 파일을 저장시키는 문장
			FileCopyUtils.copy(data, new File(realPath + uf.getNewFileName()));
			System.out.println("이미지 파일 저장");
//			if (ImgMimeType.contentTypeIsImage(contentType)) {
//				// 이미지 파일일 경우
//				// 스케일 다운 -> thumbnail 이름으로 파일 저장
//				makeThumbNailImage(uf, realPath, completePath);
//			}
		}
		
		System.out.println("======= 업로드 서비스단 종료 =======");
		return uf;
	}
	
	public static String makeCalculatePath(String realPath) {
		Calendar cal = Calendar.getInstance();
		String year = File.separator + cal.get(Calendar.YEAR);	// "\2023"
		String monthStr = "0" + (cal.get(Calendar.MONTH) + 1);
		String month = year + File.separator + monthStr.substring(monthStr.length() - 2);
		String date = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDirectroy(realPath, year, month, date);
		
		return realPath + date;
	}
	
	private static void makeDirectroy(String realPath, String...strings) {
		// realPath 경로 + /년/월/일 폴더가 모두 존재하지 않는다면
		if (!new File(realPath + strings[strings.length - 1]).exists()) {
			for (String path : strings) {
				File tmp = new File(realPath + path);
				if (!tmp.exists()) {
					tmp.mkdirs();
				}
			}
		}
	}
	
	private static String getNewFileName(String originalFilename, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();
		
		// 파일 이름이 중복되지 않게 처리하기
		// ex) "userId_UUID.확장자";
		String newFileName = uuid + "_" + originalFilename;
		
		return completePath.substring(realPath.length()) + File.separator + newFileName;
	}

	@Override
	public void deleteFile(UploadFiles uf, String realPath) {
		System.out.println("======= 업로드 서비스단 - 업로드 파일 삭제 =======");
		
		File file = new File(realPath + uf.getNewFileName());
		if (file.exists()) {
			file.delete();
		}
		
		System.out.println("======= 업로드 서비스단 종료 =======");
	}

	@Override
	public boolean isExist(UploadFiles uf) throws SQLException, NamingException {
		System.out.println("======= 업로드 서비스단 - 업로드 파일 유무 조회 =======");
		boolean result = false;
		
		if (uDao.selectUploadFile(uf) != null) {
			result = true;
		}
		
		System.out.println("======= 업로드 서비스단 종료 =======");
		return result;
	}
}
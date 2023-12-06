package com.project.etc.jmj;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import com.project.vodto.UploadFiles;

public class UploadProfileFileProcess {

	public static UploadFiles fileUpload(String originalFileName, long size, String contentType, byte[] bytes,
			String realPath, String memberId) throws IOException {
		String completePath = makeCalculatePath(realPath); // 물리적 경로 + /년/월/일
		System.out.println(completePath);

		UploadFiles uf = new UploadFiles();
		
		if(size > 0) { //파일이 존재한다면
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String ext = extension.replace(".", "");
		
			uf.setExtension(ext);
			uf.setNewFileName(getNewFileName(originalFileName, realPath, completePath));
			uf.setOriginalFileName(originalFileName);
			uf.setFileSize(size);

			FileCopyUtils.copy(bytes, new File(realPath + uf.getNewFileName())); // 원본 파일 저장

		}
		return uf;
	}

	private static String getNewFileName(String originalFileName, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();

		String newFileName = uuid + "_" + originalFileName;

		return completePath.substring(realPath.length()) + File.separator +newFileName;
	}

	private static String makeCalculatePath(String realPath) {
		Calendar cal = Calendar.getInstance();

		String year = File.separator + (cal.get(Calendar.YEAR) + ""); // "\2023"
		String month = year + File.separator + new DecimalFormat("00").format((cal.get(Calendar.MONTH) + 1)); // "\2023\11"
		String date = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // "\2023\11\01"

		System.out.println(year + ", " + month + ", " + date);

		makeDirectory(realPath, year, month, date);

		return realPath + date;
	}

	private static void makeDirectory(String realPath, String... strings) {
		if (!new File(realPath + strings[strings.length - 1]).exists()) {
			for (String path : strings) {
				File tmp = new File(realPath + path);
				if (!tmp.exists()) {
					tmp.mkdir();
				}
			}
		}
		
	}

}

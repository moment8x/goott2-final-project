package com.project.service.kjy;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Mode;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.project.etc.kjs.ImgMimeType;
import com.project.vodto.UploadFiles;

@Service
public class UploadFileServiceKjy {
	public UploadFiles uploadFileKjy(String originalFileName, long size, byte[] data, String contentType, String realPath) throws Exception {
		UploadFiles uploadFile = new UploadFiles(0, contentType, realPath, originalFileName, originalFileName, size);
		String completePath = makeCalculatePath(realPath);
		
		if(size > 0) {
			String newFileName = getNewFileName(originalFileName, realPath, completePath);
			uploadFile.setNewFileName(newFileName);
			FileCopyUtils.copy(data, new File(realPath + newFileName));
			if(ImgMimeType.contentTypeIsImage(contentType)) {
				String thumbFileName = makeThumbNailImage(uploadFile, realPath, completePath);
				if(!"실패".equals(thumbFileName)) {
					uploadFile.setThumbnailFileName(thumbFileName);
				}
			}
		}
		return uploadFile;
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
	private static String makeThumbNailImage(UploadFiles uf, String realPath, String completePath) throws IOException {
		BufferedImage originImg = ImageIO.read(new File(realPath + uf.getNewFileName())); // 원본 파일
		BufferedImage thumbNailImg = Scalr.resize(originImg, Mode.FIT_TO_HEIGHT, 50); // 리사이징
		
		String thumbImgName = "thumb_" + uf.getNewFileName().substring(uf.getNewFileName().lastIndexOf("\\") + 1);
		String ext = uf.getNewFileName().substring(uf.getNewFileName().lastIndexOf(".") + 1);
		uf.setExtension(ext);
		
		File saveTarget = new File(completePath + File.separator + thumbImgName);
		if(ImageIO.write(thumbNailImg, ext, saveTarget)) { // 썸네일 이미지를 저장 -> 성공이면 uf에 담기
			return completePath.substring(realPath.length()) + File.separator + thumbImgName;
		}
		
		return "실패";
		
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
	
	public int deleteFile(String getNewFileName, String realPath) {	
		int result = -1;
		File delFile = new File(realPath + getNewFileName);
		String thumbnailFileName = "thumb_" + getNewFileName;
		if(delFile.exists()) {
			if(thumbnailFileName.equals("") || thumbnailFileName != null) {
				File thumbFile = new File(realPath + thumbnailFileName);
				if (thumbFile.exists()) {
					thumbFile.delete();
				}
			}
			delFile.delete();
			result = 1;
		} else {
			result = 0;
		}
		return result;
	}
	
}

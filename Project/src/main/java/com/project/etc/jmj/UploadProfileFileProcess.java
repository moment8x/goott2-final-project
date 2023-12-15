package com.project.etc.jmj;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Mode;
import org.springframework.util.FileCopyUtils;

import com.project.vodto.UploadFiles;

public class UploadProfileFileProcess {

	public static UploadFiles fileUpload(String originalFileName, long size, String contentType, byte[] bytes,
			String realPath, String memberId) throws IOException {
		String completePath = makeCalculatePath(realPath); // 물리적 경로 + /년/월/일
		System.out.println(completePath);

		UploadFiles uf = new UploadFiles();

		if (size > 0) { // 파일이 존재한다면
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String ext = extension.replace(".", "");

			uf.setExtension(ext);
			uf.setNewFileName(getNewFileName(originalFileName, realPath, completePath));
			uf.setOriginalFileName(originalFileName);
			uf.setFileSize(size);

			FileCopyUtils.copy(bytes, new File(realPath + uf.getNewFileName())); // 원본 파일 저장

			if (ImgMimeType.contentTypeIsImage(contentType)) { // 이미지 파일 이라면
				// 스케일 다운 -> thumbnail 이름으로 파일 저장
				makeThumbNailImage(uf, realPath, completePath); // 썸네일 이미지 저장
			}

		}
		return uf;
	}

	private static void makeThumbNailImage(UploadFiles uf, String realPath, String completePath) throws IOException {
		BufferedImage originImg = ImageIO.read(new File(realPath + uf.getNewFileName())); // 원본 파일 읽음

		BufferedImage thumbNailImg = Scalr.resize(originImg, Mode.FIT_TO_HEIGHT, 50);

//		String thumbImgName = "thumb_" + uf.getOriginalFileName();
//
//		File saveTarget = new File(completePath + File.separator + thumbImgName);
//		String ext = uf.getOriginalFileName().substring(uf.getOriginalFileName().lastIndexOf(".") + 1);
//		if (ImageIO.write(thumbnailImg, ext, saveTarget)) {
//			uf.setThumbnailFileName(completePath.substring(realPath.length()) + File.separator + thumbImgName);
//		}
		String thumbImgName = "thumb_" + uf.getNewFileName().substring(uf.getNewFileName().lastIndexOf("\\") + 1);

		File saveTarget = new File(completePath + File.separator + thumbImgName);

		// 저장될 섬네일 이름, 확장자, 파일
		if (ImageIO.write(thumbNailImg,
				uf.getOriginalFileName().substring(uf.getOriginalFileName().lastIndexOf(".") + 1), saveTarget)) {
			// 썸네일 이미지를 저장에 성공 시
			uf.setThumbnailFileName(completePath.substring(realPath.length()) + File.separator + thumbImgName);
		}

	}

	private static String getNewFileName(String originalFileName, String realPath, String completePath) {
		String uuid = UUID.randomUUID().toString();

		String newFileName = uuid + "_" + originalFileName;

		return completePath.substring(realPath.length()) + File.separator + newFileName;
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

	public static void deleteFile(List<UploadFiles> fileList, String remFile, String realPath) {

		for (UploadFiles uf : fileList) {

			if (remFile.equals(uf.getOriginalFileName())) { // 지워야 할 파일을 찾았다
				File delFile = new File(realPath + uf.getNewFileName());
				if (delFile.exists()) {
					delFile.delete();
				}
				if (uf.getThumbnailFileName() != null) {
					File thumbFile = new File(realPath + uf.getThumbnailFileName());
					if (thumbFile.exists()) {
						thumbFile.delete();
					}
				}
			}
		}
	}

	public static void deleteAllFile(List<UploadFiles> fileList, String realPath) {
		for (UploadFiles uf : fileList) { // 모든 파일을 다 지우니까 if문 없이 지우면 된다.
			File delFile = new File(realPath + uf.getNewFileName());
			if (delFile.exists()) {
				delFile.delete();
			}
			if (uf.getThumbnailFileName() != null) {
				File thumbFile = new File(realPath + uf.getThumbnailFileName());
				if (thumbFile.exists()) {
					thumbFile.delete();
				}
			}
		}
	}

}

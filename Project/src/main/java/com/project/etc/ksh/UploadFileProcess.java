package com.project.etc.ksh;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Mode;
import org.springframework.util.FileCopyUtils;

import com.project.etc.kjs.ImgMimeType;
import com.project.vodto.InquiryFile;
import com.project.vodto.UploadFiles;


/**
 * @packageName :com.ksh.etc
 * @fileName : UploadeFileProcess.java
 * @author ksh
 * @date : 2023. 9. 3.
 * @description : 업로드된 파일을 처리한다.
 *
 */
public class UploadFileProcess {

	/**
	 * @MethodName : fileUpload
	 * @author : ksh
	 * @param : originalFilename, size, contentType, bytes, realPath
	 * @throws IOException
	 * @returnValue :
	 * @date : 2023. 9. 3.
	 * @descprition : 파일 업로드 처리의 현재 컨트롤
	 */
	public static UploadFiles fileUpload(String originalFileName, long size, String contentType, byte[] data,
			String realPath) throws IOException {
		String completePath = makeCalculatePath(realPath); // 물리적 경로 + 년/월/일
		UploadFiles uf = new UploadFiles();

		if (size > 0) {
			uf.setNewFileName(getNewFileName(originalFileName, realPath, completePath));
			uf.setOriginalFileName(originalFileName);
			uf.setFileSize(size);

			FileCopyUtils.copy(data, new File(realPath + uf.getNewFileName())); // 원본 파일 저장

			if (ImgMimeType.contentTypeIsImage(contentType)) { // contentType가 이미지파일이라면 ... 썸네일 이미지 저장
				// 스케일 다운 -> thumbnail 이름으로 저장
				makeThumbNailImg(realPath, completePath, uf);
			}

		}

//       if(uf != null) {
//          System.out.println(uf.toString());
//       }
		return uf;
	}

	/**
	 * @MethodName : makeThumbNailImg
	 * @author : ksh
	 * @param : realPath, uf
	 * @throws IOException
	 * @returnValue :
	 * @date : 2023. 9. 3.
	 * @descprition : 이미지(원본)을 읽어와 스케일 다운시키고, 썸네일 파일로 저장
	 */
	private static void makeThumbNailImg(String realPath, String completePath, UploadFiles uf) throws IOException {
		// TODO Auto-generated method stub
		BufferedImage originImg = ImageIO.read(new File(realPath + uf.getNewFileName()));

		BufferedImage thumbNailImg = Scalr.resize(originImg, Mode.FIT_TO_HEIGHT, 50);

		String thumbImgName = "thumb_" + uf.getOriginalFileName();

		File saveTarget = new File(completePath + File.separator + thumbImgName);
		String ext = uf.getOriginalFileName().substring(uf.getOriginalFileName().lastIndexOf(".") + 1);

		if (ImageIO.write(thumbNailImg, ext, saveTarget)) { // 썸네일 이미지를 저장 -> 성공하면 uf에 저장
			uf.setThumbnailFileName(completePath.substring(realPath.length()) + File.separator + thumbImgName);
		}

	}

	/**
	 * @MethodName : getNewFileName
	 * @author : ksh
	 * @param : originalFileName, realPath, completePath
	 * @returnValue : "\년\월\일\새롭고 유니한 파일이름.확장자" 반환
	 * @date : 2023. 9. 3.
	 * @descprition :
	 */
	private static String getNewFileName(String originalFileName, String realPath, String completePath) {

		String uuid = UUID.randomUUID().toString();
		String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

		String newFileName = originalFileName + "_" + uuid + ext;

		return completePath.substring(realPath.length()) + File.separator + newFileName;
	}

	public static String makeCalculatePath(String realPath) {
		// TODO Auto-generated method stub
		Calendar cal = Calendar.getInstance();
		String year = File.separator + (cal.get(Calendar.YEAR) + ""); // "\2023"
		String month = year + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // "\2023\09"

		String date = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // "\2023\09\01"

		System.out.println(year + ", " + month + ", " + date);

		makeDirectory(realPath, year, month, date);

		return realPath + date;
	}

	// 구조분해 할당 : String year, String month, String date를 한번에 받는 방법
	// ...strings : 가변 인자 메서드 기법(전달된 year, month, date 값이 strings 하나의 매개 변수로 할당된다
	// (배열방식)
	private static void makeDirectory(String realPath, String... strings) {
		// realPath 경로 + \년\월\일 폴더가 모두 존재하지 않는다면..
		if (!new File(realPath + strings[strings.length - 1]).exists()) {
			for (String path : strings) {
				File tmp = new File(realPath + path);
				if (!tmp.exists()) {
					tmp.mkdir();
				}
			}
		}

	}

	/**
	 * @MethodName : deleteFile
	 * @author : ksh
	 * @param fileList
	 * @param remInd
	 * @param realPath
	 * @returnValue :
	 * @description : fileList의 remInd번째에 있는 파일을 삭제한다
	 * @date : 2023. 9. 4.
	 */
	public static void deleteFile(List<UploadFiles> fileList, String remFile, String realPath) {
		boolean result = true;

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

	/**
	 * @MethodName : deleteAllFile
	 * @author : ksh
	 * @param fileList
	 * @param realPath
	 * @returnValue : 
	 * @description : 유저가 글쓰기를 취소했을 경우 모든 업로드된 파일을 지움
	 * @date : 2023. 9. 4.
	 */
	public static void deleteAllFile(List<UploadFiles> fileList, String realPath) {
		// TODO Auto-generated method stub
		for (UploadFiles uf : fileList) {
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
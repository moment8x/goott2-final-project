package com.project.controller.kjs;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.kjs.review.ReviewService;
import com.project.service.kjs.upload.UploadFileService;
import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Memberkjy;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Inject
	UploadFileService ufService;
	@Inject
	ReviewService rService;
	
	List<UploadFiles> fileList = new ArrayList<UploadFiles>();
	
	@RequestMapping("uploadFile")
	public @ResponseBody List<UploadFiles> uploadFile(HttpServletRequest request, MultipartFile uploadFile) {
		System.out.println("======= 리뷰게시판 컨트롤러 - 업로드 파일 =======");
		
		// 1. 파일이 저장될 경로 확인
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			// 2. 서비스단에 데이터 전송
			fileList = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(), 
						uploadFile.getContentType(), uploadFile.getBytes(), realPath, fileList);
		} catch (IOException | SQLException | NamingException e) {
			e.printStackTrace();
		}
		System.out.println("======= 리뷰게시판 컨트롤러 종료 =======");
		return fileList;
	}
	
	@RequestMapping("saveReview")
	public void saveReview(ReviewBoard review, HttpServletRequest request) {
		System.out.println("======= 리뷰게시판 컨트롤러 - 리뷰 글 작성 =======");
		
		
		// 회원 아이디 가져오기, 작성자 등록
		HttpSession session = request.getSession();
		String memberId = ((Memberkjy)session.getAttribute("loginMember")).getMemberId();
		review.setAuthor(memberId);
		
		// 리뷰 및 업로드된 이미지(uploadFileSeq) 저장
		try {
			if (rService.saveReview(review, fileList)) {
				System.out.println("컨트롤러 체크 1");
			}
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		fileList.clear();
		System.out.println("======= 리뷰게시판 컨트롤러 종료 =======");
	}
	
	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request) {
		System.out.println("======= 리뷰게시판 컨트롤러 - 페이지 이동 시 파일리스트 초기화 =======");
		
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		if (fileList.size() > 0) {
			for (UploadFiles file : fileList) {
				ufService.deleteFile(file, realPath);
			}
			fileList.clear();
		}
		
		System.out.println("======= 리뷰게시판 컨트롤러 종료 =======");
	}
	
	@RequestMapping("isValid")
	public @ResponseBody boolean isValid(HttpServletRequest request, @RequestParam("productId") String productId) {
		System.out.println("======= 리뷰게시판 컨트롤러 - 리뷰 작성 가능한가(권한) 확인 =======");
		boolean result = false;
		// 아이디 가져오기
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			try {
				if (rService.haveARecord(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), productId)) {
					result = true;
				}
			} catch (SQLException | NamingException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("======= 리뷰게시판 컨트롤러 종료 =======");
		return result;
	}
}

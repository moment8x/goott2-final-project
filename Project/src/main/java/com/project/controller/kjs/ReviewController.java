package com.project.controller.kjs;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.kjs.review.ReviewService;
import com.project.service.kjs.upload.UploadFileService;
import com.project.vodto.PagingInfo;
import com.project.vodto.ReviewBoard;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ReviewBoardDTO;
import com.project.vodto.kjy.Memberkjy;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Inject
	UploadFileService ufService;
	@Inject
	ReviewService rService;
	
	List<UploadFiles> fileList = new ArrayList<UploadFiles>();
	List<String> deleteFileList = new ArrayList<String>();
	
	@RequestMapping("uploadFile")
	public @ResponseBody List<UploadFiles> uploadFile(HttpServletRequest request, MultipartFile uploadFile) {
		// 1. 파일이 저장될 경로 확인
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			// 2. 서비스단에 데이터 전송
			fileList = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(), 
						uploadFile.getContentType(), uploadFile.getBytes(), realPath, fileList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileList;
	}
	
	@RequestMapping(value="deleteUploadFile", method=RequestMethod.POST)
	public @ResponseBody List<UploadFiles> deleteUploadedFile(HttpServletRequest request, @RequestParam("thumbFileName") String thumbFileName) {
		List<UploadFiles> result = null;
		thumbFileName = thumbFileName.replace("/", "\\");
		// 1. deleteFileList에 삭제할 파일 등록
		String newFileName = thumbFileName.replace("thumb_", "");
		deleteFileList.add(newFileName);
		// 2. fileList - deleteFileList 해서 남은 값만 return
		result = calcFileList();
		
		return result;
	}
	
	// fileList - deleteFileList 해서 남은 값만 return
	private List<UploadFiles> calcFileList() {
		List<UploadFiles> result = fileList;
		for (int i = 0; i < fileList.size(); i++) {
			for (String deleteFile : deleteFileList) {
				if (fileList.get(i).getNewFileName().equals(deleteFile)) {
					result.remove(i);
					break;
				}
			}
		}
		
		return result;
	}
	
	@RequestMapping(value="saveReview", method=RequestMethod.POST)
	public void saveReview(ReviewBoard review, HttpServletRequest request) {
		// 회원 아이디 가져오기, 작성자 등록
		HttpSession session = request.getSession();
		String memberId = ((Memberkjy)session.getAttribute("loginMember")).getMemberId();
		review.setAuthor(memberId);
		// 업로드 파일 삭제 관련
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		// 리뷰 및 업로드된 이미지(uploadFileSeq) 저장
		try {
			rService.saveReview(review, calcFileList());
			ufService.deleteUploadedFile(deleteFileList, realPath);
		} catch (SQLException | NamingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		fileList.clear();
		deleteFileList.clear();
	}
	
	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		try {
			// 업로드 되어있는 파일이 존재
			if (fileList.size() > 0) {
				for (UploadFiles file : fileList) {
						// DB에 존재하는 파일이 아니라면
						if (!ufService.isExist(file.getNewFileName())) {
							// 파일 삭제
							ufService.deleteFile(file.getNewFileName(), realPath);
						}
				}
				fileList.clear();
				deleteFileList.clear();
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("isValid")
	public ResponseEntity<Boolean> isValid(HttpServletRequest request, @RequestParam("productId") String productId) {
		ResponseEntity<Boolean> result = null;
		boolean isValid = false;
		
		// 아이디 가져오기
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			try {
				if (rService.haveARecord(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), productId)) {
					isValid = true;
					result = new ResponseEntity<Boolean>(isValid, HttpStatus.OK);
				}
			} catch (SQLException | NamingException e) {
				e.printStackTrace();
				result = new ResponseEntity<Boolean>(isValid, HttpStatus.BAD_REQUEST);
			}
		}
		return result;
	}
	
	@RequestMapping("{productId}")
	public ResponseEntity<Map<String, Object>> getDetailPage(@PathVariable("productId") String productId, @RequestParam(value="page", defaultValue = "1") int page, HttpServletRequest req) throws Exception {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> data = new HashMap<String, Object>();
		// 해당 productId로 리뷰글 조회
		Map<String, Object> map = rService.getReviewList(productId, page);
		
		@SuppressWarnings("unchecked")
		List<ReviewBoardDTO> reviewList = (List<ReviewBoardDTO>)map.get("reviewList");
		PagingInfo pagingInfo = (PagingInfo)map.get("pagingInfo");
		if (reviewList != null && pagingInfo != null) {
			data.put("reviewList", reviewList);
			data.put("pagingInfo", pagingInfo);
			result = new ResponseEntity<Map<String,Object>>(data, HttpStatus.OK);
		} else {
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return result;
    }
	
	@RequestMapping("update")
	public ResponseEntity<Map<String, Object>> updateReviewCheck(HttpServletRequest request, @RequestParam("productId") String productId, @RequestParam("postNo") int postNo) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		ReviewBoardDTO review = null;
		
		HttpSession session = request.getSession();
		String memberId = ((Memberkjy)session.getAttribute("loginMember")).getMemberId();
		
		try {
			review = rService.getReview(postNo, memberId);
			if (review.getAuthor() != null) {
				// 등록된 파일이 있는가 확인하고 있으면 fileList에 put
				for (UploadFiles uf : review.getImages()) {
					fileList.add(uf);
				}
				
				map.put("review", review);
				map.put("status", "success");
			} else {
				// 다른 ID. 리뷰 수정X
				map.put("status", "block");
			}
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch (SQLException | NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("status", "error");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateReview(HttpServletRequest request, @RequestParam("postNo") int postNo,
			@RequestParam("rating") int rating, @RequestParam("content") String content,
			@RequestParam("productId") String productId, @RequestParam("page") int page) {
		ResponseEntity<Map<String, Object>> result = null;
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			if (rService.updateReview(postNo, content, rating, calcFileList(), deleteFileList, realPath, productId)) {
				result = getDetailPage(productId, page, request);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping("delete")
	public ResponseEntity<Map<String, Object>> deleteReviewCheck(HttpServletRequest request, @RequestParam("postNo") int postNo,
			@RequestParam("productId") String productId, @RequestParam("page") int page) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> data = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		String memberId = ((Memberkjy)session.getAttribute("loginMember")).getMemberId();
		
		try {
			if (rService.deleteCheck(postNo, memberId, productId)) {
				// 삭제가 가능함이 확인되었으면 삭제
				if (rService.deleteReview(postNo)) {
					data.put("status", "OK");
					Map<String, Object> map = rService.getReviewList(productId, page);
					
					@SuppressWarnings("unchecked")
					List<ReviewBoardDTO> reviewList = (List<ReviewBoardDTO>)map.get("reviewList");
					PagingInfo pagingInfo = (PagingInfo)map.get("pagingInfo");
					if (reviewList != null && pagingInfo != null) {
						data.put("reviewList", reviewList);
						data.put("pagingInfo", pagingInfo);
						result = new ResponseEntity<Map<String,Object>>(data, HttpStatus.OK);
					} else {
						result = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
					}
				}
			} else {
				data.put("status", "denied");
				result = new ResponseEntity<Map<String,Object>>(data, HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			data.put("status", "error");
			result = new ResponseEntity<Map<String,Object>>(data, HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
}

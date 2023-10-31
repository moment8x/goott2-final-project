package com.project.controller.kym;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.kym.ReviewService;
import com.project.vodto.Board;
import com.project.vodto.UploadFile;

@Controller
@RequestMapping("/review/*")
@CrossOrigin(origins = "*")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Inject
	private ReviewService rService;

	@RequestMapping("/all/{subcategory}")
	public ResponseEntity<List<Board>> getAllReview(@PathVariable("subcategory") String subcategory) {
		System.out.println(subcategory + "리뷰를 모두 가져오자");

		HttpHeaders header = new HttpHeaders();
		header.add("content-type", "application/json; charset=UTF-8");

		ResponseEntity<List<Board>> result = null;

		try {
			List<Board> list = rService.getAllReview(subcategory);
			System.out.println(list);
			result = new ResponseEntity<List<Board>>(list, header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			// 예외가 발생하면 json으로 응답할 객체가 없기 때문에 상태코드만 전송
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}
	
	@RequestMapping(value="/file/", method = RequestMethod.POST)
	public ResponseEntity<String> saveFile(MultipartFile reviewImg) {
		System.out.println("파일 들어온다!" + reviewImg.getOriginalFilename());
		
		// 서비스 -> dao -> insert
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	

	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> saveReview(@RequestBody Board newReview, HttpServletResponse response) {
		// @RequestBody: request로 받은 파라미터를 json으로 변환해서 받아온다.
		System.out.println(newReview.toString() + "리뷰를 저장");

		ResponseEntity<String> result = null;

		HttpHeaders header = new HttpHeaders();
		header.add("content-type", "application/json; charset=UTF-8");

		try {
			if (rService.saveReview(newReview)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.FORBIDDEN);
		}

		return result;
	}
}
package com.project.controller.kym;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
//	@RequestMapping(value="all/{boardNo}", method=RequestMethod.GET)
//	public void ReviewAll(Model model, getAllReview(@pathValiabl("product_id") String product_id) throws Exception {
//		logger.info("게시판 전체 글 조회합시다");
	}
	
	

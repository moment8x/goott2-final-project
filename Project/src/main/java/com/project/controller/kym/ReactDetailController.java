package com.project.controller.kym;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.etc.kym.GetUserIPAddr;
import com.project.service.kym.ReviewService;
import com.project.service.kym.detailService;

@Controller
@RequestMapping("/details/*")
public class ReactDetailController {
	
	@Inject
	private detailService detailService;  // Product 객체 주입
	
    @Inject
    private ReviewService rService;
	
    @RequestMapping("/{productId}")
	public ResponseEntity<Map<String, Object>> detailAll(@PathVariable("productId") String productId, HttpServletRequest req) throws Exception {
//		System.out.println(productId + "항목을 조회합시다");
		
		HttpHeaders header = new HttpHeaders();
		header.add("content-type", "application/json; charset=UTF-8");
		
		ResponseEntity<Map<String, Object>> result = null;
		
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("detail/detail");
		
		try {
			Map<String, Object> map = detailService.getProductId(productId, GetUserIPAddr.getIp(req));
			result = new ResponseEntity<Map<String, Object>>(map, header, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			// 예외가 발생하면 json으로 응답할 객체가 없기 때문에 상태코드만 전송
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}
	
	
}

package com.project.controller.kym;


import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.etc.kym.GetUserIPAddr;
import com.project.service.kym.ReviewService;
import com.project.service.kym.detailService;

@Controller
@RequestMapping("/detail/*")
@CrossOrigin(origins="*")
public class detailController {
    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	
	@Inject
	private detailService detailService;  // Product 객체 주입
	
    @Inject
    private ReviewService rService;
    
    
	
    @RequestMapping("/{productId}")
	public String detailAll(@PathVariable("productId") String productId, Model model, HttpServletRequest req) throws Exception {
		System.out.println(productId + "항목을 조회합시다");
		Map<String, Object> result = detailService.getProductId(productId, GetUserIPAddr.getIp(req));
		System.out.println("1" + result);
		model.addAttribute("Product", result.get("product"));

	return "detail";
		
    }
    
//	@RequestMapping("/product_id/*")
//	public void detailAll(@RequestParam("productId") String productId, Model model, HttpServletRequest req) throws Exception {
//		System.out.println(productId + "항목을 조회합시다2");
//		Map<String, Object> result = detailService.getProductId(productId, GetUserIPAddr.getIp(req));
//		System.out.println("1" + result);
//		model.addAttribute("Product", result.get("product"));
//
//		
//	}
    

}

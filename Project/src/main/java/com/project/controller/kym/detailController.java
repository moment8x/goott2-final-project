package com.project.controller.kym;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.etc.kym.GetUserIPAddr;
import com.project.service.kym.detailService;

@Controller
public class detailController {
	
	
	@Inject
	private detailService detailService;  // Product 객체 주입
	
	@RequestMapping("/detail/*")
	public void detailAll(@RequestParam("no") String no, Model model, HttpServletRequest req) throws Exception {
		System.out.println(no + "항목을 조회합시다");
		Map<String, Object> result = detailService.getProductId(no, GetUserIPAddr.getIp(req));
		System.out.println("1" + result);
		model.addAttribute("Product", result.get("product"));

	
		
		
	}
}

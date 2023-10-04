package com.project.controller.kjs;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.WebUtils;

import com.project.controller.HomeController;

@Controller
@RequestMapping("/shoppingCart/*")
public class ShoppingCartController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	
	public void deleteList() {
		logger.info("선택된 장바구니 목록 삭제");
	}
	
	@RequestMapping("shoppingCart")
	public String basketList(HttpServletRequest request, @RequestParam(value="checkedProductId") List<String> productId) {
		logger.info("장바구니 조회");
		String result = "";
		
		// 비회원 쿠키
		Cookie nonMemberCookie = WebUtils.getCookie(request, "non");
		// 비회원 쿠키가 존재한다면...
		if (nonMemberCookie != null) {
			
		} else {
			// 비회원 쿠키가 존재하지 않는다면...
			result = "noItem";
		}
		
		return result;
	}
}
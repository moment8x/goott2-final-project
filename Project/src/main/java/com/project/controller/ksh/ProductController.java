package com.project.controller.ksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.vodto.Member;

@Controller
@RequestMapping("/detail/*")
public class ProductController {
	
	@RequestMapping(value="S000208719388", method = RequestMethod.GET)
	public String showDetail(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginMember");
		if(member != null) {
			model.addAttribute("isLogin", "Y");
		} else {
			model.addAttribute("isLogin", "N");
		}
		return "/detail/productDetail";
	}
}

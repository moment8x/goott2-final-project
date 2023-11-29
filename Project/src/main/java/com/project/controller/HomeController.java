package com.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.kjy.ListService;
import com.project.service.kjy.LoginService;
import com.project.vodto.kjy.Memberkjy;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	private ListService lservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView model) {
	Map<String, Object> map = null;
	model.setViewName("index");
		try {
			map = lservice.indexSlideList();
			model.addObject("listProductsMap", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		return model;
	}
	@RequestMapping("/etc/notice")
	public void notice() {
		
	}
	@RequestMapping("/etc/isAdmin")
	public ResponseEntity<String> isAdmin(HttpServletRequest request) {
		ResponseEntity<String> result = null;
		if(request.getSession().getAttribute("loginMember") != null) {
			Memberkjy member = (Memberkjy)request.getSession().getAttribute("loginMember");		
			try {
				if(loginService.isAdmin(member.getMemberId())) {
					result = new ResponseEntity<String>("Admin", HttpStatus.OK);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result = new ResponseEntity<String>(HttpStatus.CONFLICT);
			}
		} else {
			result = new ResponseEntity<String>("NoLogin", HttpStatus.OK);
		}
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("/etc/writeNotice")
	public void writeNotice() {
		
	}
	
}

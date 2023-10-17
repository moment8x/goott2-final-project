package com.project.controller.kjy;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@RequestMapping("/")
	public String goLogin() {
		
		
		return "/login/login";
	}
}

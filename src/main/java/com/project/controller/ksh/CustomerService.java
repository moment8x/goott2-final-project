package com.project.controller.ksh;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/cs/*")
public class CustomerService {
	
	@RequestMapping(value = "serviceCenter", method = RequestMethod.GET)
	public void testServiceCenter() {
		System.out.println("테스트입니다.");
	}
}

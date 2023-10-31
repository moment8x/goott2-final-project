package com.project.controller.ksh;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/detail/*")
public class ProductController {
	
	@RequestMapping(value="S000208719388", method = RequestMethod.GET)
	public String showDetail() {
		return "/detail/productDetail";
	}
}

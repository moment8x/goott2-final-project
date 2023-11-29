package com.project.controller.kjy;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kjy.AdminRegisteringService;
import com.project.vodto.kjy.Products;

@CrossOrigin("*")
@RestController
@RequestMapping("/admin/*")
public class AdminRegistration {
	
	private AdminRegisteringService adminRegisteringService;
	
	@ResponseBody
	@RequestMapping(value="/input", method = RequestMethod.POST)
	public void inputProduct(@RequestBody List<Products> products) {
		for(Products p : products) {
			p.getAuthorIntroduction();
		}
		adminRegisteringService.inputProducts(products);
	}

}

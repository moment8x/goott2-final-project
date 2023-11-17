package com.project.controller.kkb.admin;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RestController
@RequestMapping("/admin")
public class AdminController {
	
	@GetMapping
	public String showAdminDashboard() {
		return "Dashboard";
	}
		
	
}

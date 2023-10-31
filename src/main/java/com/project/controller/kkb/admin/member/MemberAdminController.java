package com.project.controller.kkb.admin.member;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminMemberService;
import com.project.vodto.kkb.SearchMemberRequest;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "http://localhost:5173") 
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/members")
public class MemberAdminController {
	
//	@PostMapping("/member-info")
//	public ResponseEntity<MemberParam> checkMemberInfo(@RequestBody MemberParam member) {
//		System.out.println("member:"+member);
//		
//		return new ResponseEntity<MemberParam>(member, HttpStatus.OK);
//	}
	
	private final AdminMemberService adminMemberService;
	
	@PostMapping("/member-info")
	public Map<String, Object> checkMemberInfo(@RequestBody SearchMemberRequest member) throws Exception {
		System.out.println("member:" + member.toString());		
		
			return adminMemberService.getMemberInfo(member);
	}
}

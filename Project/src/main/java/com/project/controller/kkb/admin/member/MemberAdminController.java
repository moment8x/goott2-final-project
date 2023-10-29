package com.project.controller.kkb.admin.member;

import java.util.Map;

import org.springframework.context.annotation.DependsOn;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminMemberService;
import com.project.service.kkb.admin.MemberCountListener;
import com.project.vodto.kkb.SearchMemberRequest;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/members")
public class MemberAdminController {
	
	private final AdminMemberService adminMemberService;
	private final MemberCountListener memberCount;
	
//	@GetMapping("/count")
//	public Map<String, Object> countTotalMember() throws Exception {
//		return adminMemberService.getTotalMemberCount();
//	}
	@GetMapping("/count")
	public int countTotalMember() throws Exception {
		return memberCount.getCurrentCount();
	}
	
	@PostMapping("/search")
	public Map<String, Object> searchMemberInfo(@RequestBody SearchMemberRequest member) throws Exception {
		System.out.println("member:" + member.toString());		
		
			return adminMemberService.getMemberInfo(member);
	}
	
	
}

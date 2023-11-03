package com.project.controller.kkb.admin.member;

import java.util.Map;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.annotation.DependsOn;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.dao.kkb.admin.AdminMemberDAO;
import com.project.service.kkb.admin.AdminMemberService;
import com.project.service.kkb.admin.TotalMemberCountEvent;
import com.project.vodto.kkb.SearchMemberRequest;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/members")
public class MemberAdminController {
	
	private final AdminMemberService adminMemberService;
//	private final AdminMemberDAO adminMemberRepository;
//	private final ApplicationEventPublisher publisher;
	
//	@GetMapping("/count")
//	public Map<String, Object> countTotalMember() throws Exception {
//		return adminMemberService.getTotalMemberCount();
//	}
	
//	@GetMapping("/test")
//	public void eventTest() throws Exception {
//		int updateCount = adminMemberRepository.countAll();	
//		System.out.println("context refresh");
//		publisher.publishEvent(new TotalMemberCountEvent(updateCount));
//	}
	
	@GetMapping("/member-info")
	public Map<String, Object> countTotalMember() throws Exception {
		return adminMemberService.getTotalMemberCount();
	}
	
	@PostMapping("/search")
	public Map<String, Object> searchMemberInfo(@RequestBody SearchMemberRequest member) throws Exception {
		System.out.println("member:" + member.toString());		
		
		return adminMemberService.getMemberInfo(member);
	}
	
	
}

package com.project.controller.kkb.admin;

import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminMemberService;
import com.project.vodto.kkb.MemberCondition;
import com.project.vodto.kkb.MemberParam;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/members")
public class AdminMemberController {
	
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
	
	// 총 회원 수
	@GetMapping("/count")
	public Map<String, Object> countTotalMember() throws Exception {
		return adminMemberService.getTotalMemberCount();
	}
	
	// 회원 정보 조회
	@PostMapping("/search")
	public Map<String, Object> searchMemberInfo(@RequestBody MemberCondition member) throws Exception {
		System.out.println("member:" + member.toString());		
		
		return adminMemberService.getMemberInfo(member);
	}
	
	// CRM 홈
	@GetMapping("/{memberId}")
	public Map<String, Object> searchMemberDetailHome(@PathVariable("memberId") String memberId) throws Exception {
		return adminMemberService.getHomeDetailInfo(memberId);
	}
	
	// CRM 회원 상세정보
	@GetMapping("/detail/{memberId}")
	public Map<String, Object> searchMemberDetail(@PathVariable("memberId") String memberId) throws Exception {
		return adminMemberService.getMemberDetailInfo(memberId);
	}
	
	// CRM 회원 상세정보 수정
	@PutMapping("/detail/update")
	public Map<String, Object> modifyMemberDetail(@RequestBody MemberParam member) throws Exception {
		return adminMemberService.editMemberDetailInfo(member);
	}
	
	
}

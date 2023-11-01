package com.project.controller.kjs;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.etc.kjs.SessionCheck;
import com.project.service.member.MemberService;
import com.project.vodto.Member;

@Controller
@RequestMapping("/logintest/*")
public class LoginTestController {
	
	@Inject
	private MemberService mService;
	
	@RequestMapping("main")
	public void moveLoginPage() {
		System.out.println("왔다가요");
	}
	
	@RequestMapping("isId")
	public ResponseEntity<String> isId(@RequestParam String memberId) {
		ResponseEntity<String> result = null;
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("memberId : " + memberId);
		try {
			if (!mService.checkedDuplication(memberId)) {
				result = new ResponseEntity<String>("ok", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("no member ID",HttpStatus.OK);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}		
		return result;
	}
	
	@RequestMapping("login")
	public ResponseEntity<Map<String, Object>> checkPwd(HttpServletRequest request, @RequestParam String memberId, @RequestParam String password) {
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("######################################################");
		HttpSession session = request.getSession();
		try {
			Member member = mService.login(memberId, password);
			if (member != null) {
				map.put("member", member);
				map.put("status", "success");
				
				session.setAttribute("loginMember", member);	// 로그인 기록 세션에 남기기
				
				System.out.println("현재 로그인한 유저 : " + member.getMemberId() + ", 세션 ID : " + session.getId());
				
				// 로그인 시 세션 key 값을 로그인한 유저 아이디로 교체
				// 중복 로그인(기존 로그인 정보 지우고, 새 로그인 정보 삽입)
				SessionCheck.replaceSessionKey(session, member.getMemberId());
				
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} else {
				map.put("status", "noMember");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			}
			
		} catch (SQLException | NamingException e) {
			map.put("status", "fail");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request) {
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		HttpSession session = request.getSession();
		
		if ((Member)session.getAttribute("loginMember") != null) {
			SessionCheck.removeKey(((Member)session.getAttribute("loginMember")).getMemberId());
		}
		
		return "redirect:/";
	}
}
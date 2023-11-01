package com.project.controller.kjs;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.member.MemberService;
import com.project.vodto.Member;

@Controller
@RequestMapping("/register/*")
public class RegisterController {
	
	@Inject
	private MemberService mService;
	
	@RequestMapping("register")
	public ModelAndView moveRegister() {
		System.out.println("======= 회원가입 컨트롤러 - 회원가입 페이지 이동 =======");
		ModelAndView mav = new ModelAndView("register/register");
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
		return mav;
	}
	
	@RequestMapping("checkedId")
	public ResponseEntity<Map<String, Object>> checkedId(@RequestParam("memberId") String memberId) {
		System.out.println("======= 회원가입 컨트롤러 - 아이디 중복 체크 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if (mService.checkedDuplication(memberId)) {
				// 중복된 아이디 X
				map.put("status", "success");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} else {
				//중복된 아이디 존재
				map.put("status", "fail");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
			}
			
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			map.put("status", "fail");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
		return result;
	}
	
	@RequestMapping(value="signUp", method=RequestMethod.POST)
	public void signUp(Member member, Model model) {
		System.out.println("======= 회원가입 컨트롤러 - 회원가입 =======");
		
		try {
			mService.insertMember(member);
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
	}
}
package com.project.controller.kjs;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.kjs.upload.UploadFileService;
import com.project.service.member.MemberService;
import com.project.vodto.Member;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.NaverRegisterInfo;


@Controller
@RequestMapping("/register/*")
public class RegisterController {
	
	@Inject
	private MemberService mService;
	@Inject
	private UploadFileService ufService;
	
//	private UploadFile file = new UploadFile();
	private List<UploadFiles> fileList = null;
	
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
			System.out.println("zipCode : " + member.getZipCode());
			System.out.println("address : " + member.getAddress());
			System.out.println("detailAddress : " + member.getDetailedAddress());
			if (fileList.size() > 0) {
				mService.insertMember(member, fileList.get(0));
			} else {
				mService.insertMember(member, null);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
	}
	
	@RequestMapping(value="uploadFile", method=RequestMethod.POST)
	public @ResponseBody UploadFiles uploadFile(HttpServletRequest request, MultipartFile uploadFile) {
		System.out.println("======= 회원가입 컨트롤러 - 프로필 사진 등록 =======");
		
		// 1. 파일이 저장될 경로 확인
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			// 2. 파일 업로드
			if (fileList.get(0) != null) {
				// 기존 파일 삭제. 단, DB에 저장된 파일일 경우 삭제X
				if (!ufService.isExist(fileList.get(0))) {
					ufService.deleteFile(fileList.get(0), realPath);
				}
			}
			// 새 파일 업로드.
			fileList = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(), 
					uploadFile.getContentType(), uploadFile.getBytes(), realPath, fileList);
		} catch (IOException | SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
		return fileList.get(0);
	}
	
	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request) {
		System.out.println("======= 회원가입 컨트롤러 - 프로필 사진 초기화 =======");
		
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		if (fileList.size() > 0) {
			ufService.deleteFile(fileList.get(0), realPath);
			fileList.clear();
		}
		
		System.out.println("======= 회원가입 컨트롤러 끝 =======");
	}
	
	@RequestMapping("snsRegister")
	public void snsRegister(@RequestParam("uerInfo") NaverRegisterInfo naverInfo) {
		System.out.println("================스타트=================");
		System.out.println("왔다 감 영민♥승준 " + naverInfo);
		
		System.out.println("================끝났음=================");
	}
}
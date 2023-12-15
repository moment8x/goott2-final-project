package com.project.controller.kjs;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.kjs.upload.UploadFileService;
import com.project.service.member.MemberService;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.SnsRegisterInfo;
import com.project.vodto.kjs.SignUpDTO;
import com.project.vodto.kjs.TermsOfSignUpVO;


@Controller
@RequestMapping("/register/*")
public class RegisterController {
	
	@Inject
	private MemberService mService;
	@Inject
	private UploadFileService ufService;
	
	@RequestMapping("register")
	public String moveRegister(Model model) {
		try {
			List<TermsOfSignUpVO> data = mService.getTerms();
			model.addAttribute("terms", data);
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		return "/register/register";
	}
	
	@RequestMapping("checkedId")
	public ResponseEntity<Map<String, Object>> checkedId(@RequestParam("memberId") String memberId) {
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
		return result;
	}
	
	@RequestMapping(value="signUp", method=RequestMethod.POST)
	public @ResponseBody String signUp(@RequestBody SignUpDTO member, Model model) {
		try {
			if (member.getFileList() != null) {
				mService.insertMember(member);
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	@RequestMapping(value="uploadFile", method=RequestMethod.POST)
	public ResponseEntity<UploadFiles> uploadFile(HttpServletRequest request, MultipartFile uploadFile, String fileName) {
		// 1. 파일이 저장될 경로 확인
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		UploadFiles file = null;
		try {
			// 2. 파일 업로드
			// 기존 파일 삭제. 단, DB에 저장된 파일일 경우 삭제X
			if (!ufService.isExist(fileName)) {
				ufService.deleteFile(fileName, realPath);
			}
			// 새 파일 업로드.
			file = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(), 
					uploadFile.getContentType(), uploadFile.getBytes(), realPath);
		} catch (IOException | SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<UploadFiles>(file, HttpStatus.OK);
	}
	
	@RequestMapping("refreshFile")
	public ResponseEntity<String> refreshFile(HttpServletRequest request, @RequestBody String fileName) {
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		try {
			// 업로드 되어있는 파일이 존재
			if (!fileName.equals("")) {
				// DB에 존재하는 파일이 아니라면
				if (!ufService.isExist(fileName)) {
					// 파일 삭제
					ufService.deleteFile(fileName, realPath);
				}
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>("OK", HttpStatus.OK);
	}
	
	@RequestMapping("sendMail")
	public ResponseEntity<String> sendMail(HttpServletRequest request, @RequestParam("email") String email) {
		ResponseEntity<String> result = null;
		
		String code = UUID.randomUUID().toString();
		request.getSession().setAttribute("authCode", code);
		System.out.println("code : " + code);
		try {
			mService.sendEmail(email, code);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (MessagingException e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	@RequestMapping("confirmCode")
	public ResponseEntity<String> confirmCode(HttpServletRequest request, @RequestParam("emailCode") String emailCode) {
		ResponseEntity<String> result = null;
		String code = (String)request.getSession().getAttribute("authCode");
		
		if (mService.confirmCode(code, emailCode)) {
			result = new ResponseEntity<String>("pass", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return result;
	}
	
	@RequestMapping("snsRegister")
	public String snsRegister(Model model) {
		SnsRegisterInfo snsInfo = (SnsRegisterInfo) model.asMap().get("snsInfo");
		if (snsInfo.getEmail() != null) {
			// 네이버
			String id = mService.randomId(snsInfo.getId());
			model.addAttribute("id", id);
			model.addAttribute("email", snsInfo.getEmail());
			model.addAttribute("mobile", snsInfo.getMobile());
			model.addAttribute("name", snsInfo.getName());
			model.addAttribute("birthday", snsInfo.getBirthyear() + "-" + snsInfo.getBirthday());
			model.addAttribute("mobile_e164", snsInfo.getMobile_e164());
			
			try {
				List<TermsOfSignUpVO> data = mService.getTerms();
				model.addAttribute("terms", data);
			} catch (SQLException | NamingException e) {
				e.printStackTrace();
			}
		} else {
			// 카카오
		}
		
		return "redirect:/register/register?snsSignUp=1";
	}
	
	@RequestMapping("jusoPopup")
	public void findAddr() {}
}
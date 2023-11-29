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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.kjs.upload.UploadFileService;
import com.project.service.member.MemberService;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.SnsRegisterInfo;
import com.project.vodto.kjs.SignUpDTO;


@Controller
@RequestMapping("/register/*")
public class RegisterController {
	
	@Inject
	private MemberService mService;
	@Inject
	private UploadFileService ufService;
	
	private List<UploadFiles> fileList = null;
	
	@RequestMapping("register")
	public ModelAndView moveRegister() {
		ModelAndView mav = new ModelAndView("register/register");
		
		return mav;
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
	public void signUp(SignUpDTO member, Model model) {
		
		try {
			System.out.println("number1 : " + member.getPhoneNumber1());
			System.out.println("number2 : " + member.getPhoneNumber2());
			System.out.println("number3 : " + member.getPhoneNumber3());
			System.out.println("cellNumber1 : " + member.getCellPhoneNumber1());
			System.out.println("cellNumber2 : " + member.getCellPhoneNumber2());
			System.out.println("cellNumber3 : " + member.getCellPhoneNumber3());
			
			if (fileList != null) {
				mService.insertMember(member, fileList.get(0));
				fileList.clear();
			} else {
				mService.insertMember(member, null);
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="uploadFile", method=RequestMethod.POST)
	public @ResponseBody UploadFiles uploadFile(HttpServletRequest request, MultipartFile uploadFile) {
		// 1. 파일이 저장될 경로 확인
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			// 2. 파일 업로드
			if (fileList.get(0) != null) {
				// 기존 파일 삭제. 단, DB에 저장된 파일일 경우 삭제X
				if (!ufService.isExist(fileList.get(0).getNewFileName())) {
					ufService.deleteFile(fileList.get(0).getNewFileName(), realPath);
				}
			}
			// 새 파일 업로드.
			fileList = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(), 
					uploadFile.getContentType(), uploadFile.getBytes(), realPath, fileList);
		} catch (IOException | SQLException | NamingException e) {
			e.printStackTrace();
		}
		
		return fileList.get(0);
	}
	
	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request) {
		
		String realPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		if (fileList.size() > 0) {
			ufService.deleteFile(fileList.get(0).getNewFileName(), realPath);
			fileList.clear();
		}
	}
	
	@RequestMapping("sendMail")
	public ResponseEntity<String> sendMail(HttpServletRequest request, @RequestParam("email") String email) {
		System.out.println("메일 보내기");
		ResponseEntity<String> result = null;
		
		String code = UUID.randomUUID().toString();
		request.getSession().setAttribute("authCode", code);
		
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
		System.out.println("코드 검증");
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
	public void snsRegister(Model model) {
		System.out.println("================스타트=================");
		SnsRegisterInfo snsInfo = (SnsRegisterInfo) model.asMap().get("snsInfo");
		System.out.println("정보받음 " + snsInfo);
		
		System.out.println("================끝났음=================");
	}
}
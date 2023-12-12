package com.project.controller.ksh;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
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
import com.project.service.ksh.inquiry.InquiryService;
import com.project.service.ksh.sms.SmsService;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.CustomerInquiryDTO;
import com.project.vodto.ksh.PagingInfo;

@Controller
@RequestMapping(value = "/cs/*")
public class CustomerServiceController {

	@Value(value = "${my-test.phoneNumber}")
	private String testPhone;
	
	@Inject
	UploadFileService ufService;

	@Inject
	InquiryService inquiryService;

//  문자
	@Inject
	private SmsService smsService;

	boolean update = false;

	@RequestMapping(value = "serviceCenter", method = RequestMethod.GET)
	public void testServiceCenter() {
		System.out.println("고객센터 페이지");
	}

	@RequestMapping(value = "makeInquiry", method = RequestMethod.GET)
	public String makeInquiry(HttpServletRequest request) {
		String path = isLogin("makeInquiry", request);
		System.out.println("1:1 문의 신청");
		return path;
	}

	@RequestMapping(value = "uploadFile", method = RequestMethod.POST) // 서버
	public @ResponseBody UploadFiles uploadFile(HttpServletRequest request, MultipartFile uploadFile) {
		// 1. 파일이 저장될 경로 확인
		System.out.println("안녕요");
		UploadFiles files = null;
		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");
		try {
			// 2. 서비스단에 데이터 전송
			files = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(),
					uploadFile.getContentType(), uploadFile.getBytes(), realPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return files;
	}

	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request, @RequestBody CustomerInquiryDTO inquiry) {

		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");

		if (inquiry.getObjList().size() > 0) {
			for (UploadFiles file : inquiry.getObjList()) {
				ufService.deleteFile(file.getNewFileName(), realPath);
			}

			System.out.println("리프레쉬끝");
		}
	}

	@RequestMapping(value = "saveInquiry", method = RequestMethod.POST)
	public String saveInquiry(@RequestBody CustomerInquiryDTO inquiry, HttpServletRequest request) {
		System.out.println(inquiry.toString());
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		
		try {
			inquiry.setAuthor(member.getMemberId());
			inquiryService.saveInquiry(inquiry, inquiry.getObjList());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/cs/viewInquiry";
	}

	public String isLogin(String path, HttpServletRequest request) {
		String returnPath = "redirect:/login/?csPath=" + path;
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			returnPath = "/cs/" + path;
		}
		return returnPath;
	}

	@RequestMapping(value = "viewInquiry", method = RequestMethod.GET)
	public String viewInquiry(HttpServletRequest request, Model model,
			@RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
		String path = isLogin("viewInquiry", request);
		System.out.println(pageNo + "페이지의 1:1 문의 내역");
		List<CustomerInquiry> myInquiries = null;
		PagingInfo pi = null;
		if (path.contains("cs")) {
			HttpSession session = request.getSession();
			if (session.getAttribute("loginMember") != null) {
				String memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
				// 제목, 답변상태, 글 번호 필요
				try {
					Map<String, Object> map = inquiryService.getInquiries(memberId, pageNo);
					myInquiries = (List<CustomerInquiry>) map.get("myInquiries");
					pi = (PagingInfo) map.get("pagingInfo");
					System.out.println(myInquiries.toString());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				model.addAttribute("myInquiries", myInquiries);
				model.addAttribute("pagingInfo", pi);
			}
		}
		return path;
	}

	@RequestMapping(value = "removeSpecificImg", method = RequestMethod.GET)
	public @ResponseBody UploadFiles removeSpecificImg(@RequestParam("fileName") String thumbFileName,
			@RequestParam("purpose") String purpose, HttpServletRequest request) {
		// 서버만 지우기
		UploadFiles result = new UploadFiles();
		System.out.println("오긴와?" + purpose.toString());
		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");
		String fileName = thumbFileName.replace("thumb_", ""); // newFileName
		UploadFiles file = new UploadFiles();
		file.setNewFileName(fileName);
		file.setThumbnailFileName(thumbFileName);
		result = file;


//		int i = 0;
		if (purpose.equals("true")) {
			System.out.println("수정 시 파일 삭제");
			//deleteFileList.add(file);
			
		} else if (purpose.equals("delete")) {
			System.out.println("일단 여기까지 오긴한다만...");
			if (ufService.deleteFile(file, realPath) > 0) {
				System.out.println("작성할 때 올린 파일 취소!");
			}
		} else {
			if (ufService.deleteFile(file, realPath) > 0) {
				System.out.println("진짜지운다?");
//				for (UploadFiles uf : fileList) {
//					System.out.println("uf : " + uf.getNewFileName());
//					System.out.println("fileName : " + fileName.substring(12));
//					if (uf.getNewFileName().contains(fileName.substring(12))) {
//
//						break;
//					}
////					i++;
//				}
//				fileList.remove(i);
				
			}
		
		}

		return result;
	}

	@RequestMapping(value = "detailInquiry", method = RequestMethod.GET)
	public String detailInquiry(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String memberId = "";
		CustomerInquiryDTO inquiry = new CustomerInquiryDTO();
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		if (session.getAttribute("loginMember") != null) {
			memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
			
		} else {
			model.addAttribute("isLogin", "fail");
			return "redirect:/cs/viewInquiry";
		}
		try {
			if (inquiryService.checkValidation(postNo, memberId) > 0) {
				if (request.getParameter("postNo") != null || request.getParameter("postNo") != "") {
					System.out.println("여기안옴?");
					inquiry = inquiryService.viewDetailInquiry(memberId, postNo);

					if (inquiry.getUploadFilesSeq() > 0) {
						System.out.println("파일이 있다고요");
						List<UploadFiles> uploadFiles = inquiryService.getInquiryFiles(inquiry.getAuthor(), postNo);

						if (uploadFiles != null) {
							model.addAttribute("uploadFiles", uploadFiles);
						}
					} else {

					}
					update = true;
					System.out.println(inquiry.toString());
					model.addAttribute("inquiry", inquiry);

				}
			} else {
				model.addAttribute("status", "idMismatch");
				return "/cs/viewInquiry";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/cs/makeInquiry";
	}

	@RequestMapping(value = "updateInquiry", method = RequestMethod.POST)
	public ResponseEntity<String> updateInquiry(@RequestBody CustomerInquiryDTO inquiry, HttpServletRequest request) {

		System.out.println(inquiry.toString());
		ResponseEntity<String> result = null;
		HttpSession session = request.getSession();
		// postNo 조작해서 넘어올 수 있으므로 체크 필요 (수정하려는 사람이 수정하려는 글의 작성자와 일치하는지)
		try {
			if (session.getAttribute("loginMember") != null) {
				String memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
				System.out.println(memberId.toString());
				int yaho = inquiryService.checkValidation(inquiry.getPostNo(), memberId);
				System.out.println("야호!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + yaho);
				if (yaho > 0) { // inquiry 가져옴
					// 작성자 일치, 수정 가능
					inquiry.setAuthor(memberId);
					if (inquiry.getDeleteList().size() > 0) {
						for (UploadFiles delFile : inquiry.getDeleteList()) {
							removeSpecificImg(delFile.getThumbnailFileName(), "delete", request);
						}
					}
					if (inquiryService.updateInquiry(inquiry, inquiry.getDeleteList(), inquiry.getObjList()) > 0) {
						System.out.println("파일처리 무찔렀다! 와아!");
						result = new ResponseEntity<String>("success", HttpStatus.OK);
					}
					;
				}
				;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteInquiryBoard(HttpServletRequest request) {
		String result = "redirect:/cs/viewInquiry";
		HttpSession session = request.getSession();
		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		try {

			if (session.getAttribute("loginMember") != null) {
				String memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
				if (inquiryService.deleteInquiry(postNo, memberId, realPath) > 0) {
					System.out.println(postNo + "번 문의 글 삭제 완료");
				}
			} else {
				result = "redirect:/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}

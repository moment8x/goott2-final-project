package com.project.controller.ksh;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.vodto.ksh.PagingInfo;
import com.project.service.kjs.upload.UploadFileService;
import com.project.service.ksh.inquiry.InquiryService;
import com.project.vodto.CustomerInquiry;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.ksh.CustomerInquiryDTO;

@Controller
@RequestMapping(value = "/cs/*")
public class CustomerServiceController {

	@Inject
	UploadFileService ufService;

	@Inject
	InquiryService inquiryService;
	

	List<UploadFiles> fileList = new ArrayList<UploadFiles>();
	List<UploadFiles> deleteFileList = new ArrayList<UploadFiles>();


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
	public @ResponseBody List<UploadFiles> uploadFile
	(HttpServletRequest request, MultipartFile uploadFile, @RequestParam(value="files2[]", defaultValue = "") ArrayList<UploadFiles> files) {
		// 1. 파일이 저장될 경로 확인
		System.out.println("안녕요");
		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");
		try {
			// 2. 서비스단에 데이터 전송
			System.out.println(files.toString());
//			fileList = ufService.uploadFile(uploadFile.getOriginalFilename(), uploadFile.getSize(),
//					uploadFile.getContentType(), uploadFile.getBytes(), realPath, fileList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(fileList.toString());
		return fileList;
	}

	@RequestMapping("refreshFile")
	public void refreshFile(HttpServletRequest request) {

		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");

		if (fileList.size() > 0) {
			for (UploadFiles file : fileList) {
				ufService.deleteFile(file.getNewFileName(), realPath);
			}
			fileList.clear();
			deleteFileList.clear();
			
			
			System.out.println("리프레쉬끝");
		}
	}

	@RequestMapping(value = "saveInquiry", method = RequestMethod.POST)
	public String saveInquiry(CustomerInquiry inquiry, HttpServletRequest request) {
		System.out.println(inquiry.toString());
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");

		try {
			inquiry.setAuthor(member.getMemberId());
			inquiryService.saveInquiry(inquiry, fileList);
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
	public String viewInquiry(HttpServletRequest request, Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo) {
		String path = isLogin("viewInquiry", request);
		System.out.println(pageNo +"페이지의 1:1 문의 내역");
		List<CustomerInquiry> myInquiries = null;
		PagingInfo pi = null;
		if (path.contains("cs")) {
			HttpSession session = request.getSession();
			if (session.getAttribute("loginMember") != null) {
				String memberId = ((Memberkjy) session.getAttribute("loginMember")).getMemberId();
				// 제목, 답변상태, 글 번호 필요
				try {
					Map<String, Object> map = inquiryService.getInquiries(memberId,pageNo);
					myInquiries = (List<CustomerInquiry>)map.get("myInquiries");
					pi = (PagingInfo)map.get("pagingInfo");
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
	public ResponseEntity<String> removeSpecificImg(@RequestParam("fileName") String thumbFileName,
			@RequestParam("purpose") String purpose, HttpServletRequest request) {
		// 서버만 지우기
		System.out.println("오긴와?" + purpose.toString());
		String realPath = request.getSession().getServletContext().getRealPath("resources/inquiryUploads");
		String fileName = thumbFileName.replace("thumb_", ""); // newFileName
		UploadFiles file = new UploadFiles();
		file.setNewFileName(fileName);
		file.setThumbnailFileName(thumbFileName);
		ResponseEntity<String> result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);
		int i = 0;
		if (purpose.equals("true")) {
			System.out.println("수정하는데 파일 삭제하세요?");
			deleteFileList.add(file);
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else if (purpose.equals("delete")) {
			if (ufService.deleteFile(file, realPath) > 0) {
				System.out.println("작성할 때 올린 파일 취소!");
			}
		} else {
			if (ufService.deleteFile(file, realPath) > 0) {
				System.out.println("진짜지운다?");
				for (UploadFiles uf : fileList) {
					System.out.println("uf : " + uf.getNewFileName());
					System.out.println("fileName : " + fileName.substring(12));
					if (uf.getNewFileName().contains(fileName.substring(12))) {

						break;
					}
					i++;
				}
				fileList.remove(i);
				result = new ResponseEntity<String>("success", HttpStatus.OK);
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
			return "/cs/viewInquiry";
		}
		try {
			if (inquiryService.checkValidation(postNo, memberId) > 0) {
				if (request.getParameter("postNo") != null || request.getParameter("postNo") != "") {
					System.out.println("여기안옴?");
					fileList.clear();
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
	public String updateInquiry(CustomerInquiry inquiry, HttpServletRequest request) {
		
		System.out.println(deleteFileList.toString());
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
					if (deleteFileList.size() > 0) {
						for (UploadFiles delFile : deleteFileList) {
							removeSpecificImg(delFile.getThumbnailFileName(), "delete", request);
						}
					}
					System.out.println(deleteFileList.toString());
					if (inquiryService.updateInquiry(inquiry, deleteFileList, fileList) > 0) {
						System.out.println("파일처리 무찔렀다! 와아!");
					}
					;
					fileList.clear();
					deleteFileList.clear();
				}
				;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		
		return "redirect:/cs/detailInquiry?postNo=" + inquiry.getPostNo();
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

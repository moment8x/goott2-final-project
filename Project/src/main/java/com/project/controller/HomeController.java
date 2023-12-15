package com.project.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.service.kjs.upload.UploadFileService;
import com.project.service.kjy.ListService;
import com.project.service.kjy.LoginService;
import com.project.service.kjy.NoticeService;
import com.project.service.kjy.UploadFileServiceKjy;
import com.project.vodto.Board;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Memberkjy;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private UploadFileServiceKjy fileService;
	
	@Inject
	private LoginService loginService;
	
	@Inject
	private NoticeService noticeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	private ListService lservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView model) {
	Map<String, Object> map = null;
	model.setViewName("index");
		try {
			map = lservice.indexSlideList();
			model.addObject("listProductsMap", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		return model;
	}
	@RequestMapping("/etc/notice")
	public void notice(Model model, HttpServletRequest request, @RequestParam(value="pageNo", defaultValue = "1") int pageNo) {
		try {
			Map<String, Object> boardMap = noticeService.getNotice(pageNo);
			model.addAttribute("boardMap", boardMap);
			
			if(request.getSession().getAttribute("loginMember") != null) {
				Memberkjy member = (Memberkjy)request.getSession().getAttribute("loginMember");		
				try {
					if(loginService.isAdmin(member.getMemberId())) {
						model.addAttribute("isAdmin", "admin");
					} else {
						model.addAttribute("isAdmin", "noAdmin");
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				model.addAttribute("isAdmin", "noLogin");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/etc/isAdmin")
	public ResponseEntity<String> isAdmin(HttpServletRequest request) {
		ResponseEntity<String> result = null;
		if(request.getSession().getAttribute("loginMember") != null) {
			Memberkjy member = (Memberkjy)request.getSession().getAttribute("loginMember");		
			try {
				if(loginService.isAdmin(member.getMemberId())) {
					result = new ResponseEntity<String>("Admin", HttpStatus.OK);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				result = new ResponseEntity<String>(HttpStatus.CONFLICT);
			}
		} else {
			result = new ResponseEntity<String>("NoLogin", HttpStatus.OK);
		}
		return result;
	}
	
	@RequestMapping("/etc/writeNotice")
	public void writeNotice(@RequestParam(value="postNo", defaultValue = "-1") int postNo, Model model) {
		if(postNo != -1) {
			try {
				Board board = noticeService.getBoardByPostNo(postNo);
				model.addAttribute("board", board);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", e);
			}
		} else {
			model.addAttribute("board", "noBoard");
		}
	}
	
	@RequestMapping(value="/etc/uploadImage", method = RequestMethod.POST)
	public ResponseEntity<UploadFiles> uploadImage(@RequestParam("image") MultipartFile image, HttpServletRequest request) {
		ResponseEntity<UploadFiles> result = null;
		List<UploadFiles> fileList = new ArrayList<UploadFiles>();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		try {
			fileList.add(fileService.uploadFileKjy(image.getOriginalFilename(), image.getSize(), image.getBytes(), image.getContentType(), realPath));
			for(UploadFiles file :fileList) {
				if(file.getOriginalFileName().equals(image.getOriginalFilename())) {
					result = new ResponseEntity<UploadFiles>(file, HttpStatus.OK);
				}
			}
		} catch (Exception  e) {
			result = new ResponseEntity<UploadFiles>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "/etc/saveNotice", method = RequestMethod.POST)
	public ModelAndView saveNotice(HttpServletRequest request, ModelAndView model,@RequestParam("editordata") String editordata, @RequestParam("state") String state, @RequestParam("subj") String subj) {
		Board board = new Board();
		try {
			if(request.getSession().getAttribute("loginMember") != null) {
				Memberkjy member = (Memberkjy)request.getSession().getAttribute("loginMember");
				board.setAuthor(member.getMemberId());
				if(state.equals("공지사항")) {
					board.setCategoryId(3);
				} else {
					board.setCategoryId(4);
				}
				board.setTitle(subj);
				board.setContent(editordata.replaceAll("&nbsp;", ""));
				if(noticeService.saveNotice(board)) {
					model.setViewName("redirect:/etc/notice");
					model.addObject("state", "success");
				} else {
					model.setViewName("redirect:/etc/writeNotice");
					model.addObject("state", "fail");
				}
			} else {
				model.setViewName("/etc/writeNotice");
				model.addObject("state", "fail");
				model.addObject("board", board);
				model.addObject("error", "다시 한번 로그인 해 주세요");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addObject("state", "fail");
			model.addObject("error", e);
			model.setViewName("redirect:/etc/writeNotice");
		}
		return model;
	}
	@RequestMapping("/etc/readNotice")
	public void readBoard(@RequestParam("no")int no, Model model, @RequestParam(value="pageNo", defaultValue = "1") int pageNo) {
		try {
			Board board = noticeService.getNoticeByNo(no);
			Map<String, Object> map = noticeService.getNoticeReply(pageNo, no);
			model.addAttribute("board", board);
			model.addAttribute("replyMap", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/etc/moveNotice", method = RequestMethod.POST)
	public ResponseEntity<String> moveNotice(@RequestParam("state") String state, @RequestParam("no") String no) {
		ResponseEntity<String> result = null;
		try {
			String postNo = Integer.toString(noticeService.getNoticePostNo(state, no));
			result = new ResponseEntity<String>(postNo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("error : "+ e, HttpStatus.OK);
		}
		return result;
	}
	@RequestMapping(value="/etc/modifyNotice", method = RequestMethod.POST)
	public ModelAndView modifyNotice(HttpServletRequest request, ModelAndView model,@RequestParam("postNo") int postNo ,@RequestParam("editordata") String editordata, @RequestParam("state") String state, @RequestParam("subj") String subj) {
		Board board = new Board();
		if(request.getSession().getAttribute("loginMember") != null) {
				Memberkjy member = (Memberkjy)request.getSession().getAttribute("loginMember");
				board.setAuthor(member.getMemberId());
				if(state.equals("공지사항")) {
					board.setCategoryId(3);
				} else {
					board.setCategoryId(4);
				}
				board.setPostNo(postNo);
				board.setTitle(subj);
				board.setContent(editordata.replaceAll("&nbsp;", ""));
				try {
					if(noticeService.modifyNotice(board)) {
						model.setViewName("redirect:/etc/notice");
						model.addObject("state", "success");
					} else {
						model.setViewName("redirect:/etc/writeNotice");
						model.addObject("state", "fail");
						model.addObject("error", "다시 한번 시도해주시고, 그래도 실패하셨을 경우에는 문의해주십시오.");
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				model.setViewName("/etc/writeNotice");
				model.addObject("state", "fail");
				model.addObject("board", board);
				model.addObject("error", "다시 한번 로그인 해 주세요");
			}
		return model;
	}
	@RequestMapping(value="/etc/deleteNotice", method = RequestMethod.POST)
	public ResponseEntity<String> deleteNotice(@RequestParam("postNo") int postNo, HttpServletRequest request) {
		ResponseEntity<String> result = null;
		Board board = new Board();
		if(request.getSession().getAttribute("loginMember") != null) {
			Memberkjy member = (Memberkjy) request.getSession().getAttribute("loginMember");
			board.setPostNo(postNo);
			board.setAuthor(member.getMemberId());
			try {
				if(noticeService.removeNotice(board)){
					result = new ResponseEntity<String>("success", HttpStatus.OK);
				} else {
					result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
				}
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<String>("error", HttpStatus.UNAUTHORIZED);
			}
		}  else {
			result = new ResponseEntity<String>("logout", HttpStatus.OK);
		}
		return result;
	}
	@RequestMapping(value="/etc/replyUploadImage", method = RequestMethod.POST)
	public @ResponseBody UploadFiles replyUploadImage(@RequestPart("replyImages") MultipartFile[] multipartFiles, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		UploadFiles uf = null;
		try {
			uf = fileService.uploadFileKjy(multipartFiles[0].getOriginalFilename(), multipartFiles[0].getSize(), multipartFiles[0].getBytes(), multipartFiles[0].getContentType(), realPath);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return uf;
	}
	@RequestMapping(value="/etc/inputNoticeReply", method = RequestMethod.POST)
	public ResponseEntity<String> inputNoticeReply(@RequestBody Map<String, Object> requestData, HttpServletRequest request) {
		ResponseEntity<String> result = null;

		try {
			if(request.getSession().getAttribute("loginMember") != null) {
				Memberkjy member = (Memberkjy) request.getSession().getAttribute("loginMember");
				
				ObjectMapper objectMapper = new ObjectMapper();
				List<UploadFiles> fileList = objectMapper.convertValue(requestData.get("replyUpload"), new TypeReference<List<UploadFiles>>() {});

				int parentPost = Integer.parseInt((String)requestData.get("parentNo"));
				String content = (String) requestData.get("replyText");

				Board board = new Board();
				board.setAuthor(member.getMemberId());
				board.setParentPost(parentPost);
				board.setContent(content);
				if(noticeService.inputNoticeReply(board, fileList)) {

				result =  new ResponseEntity<String>("success", HttpStatus.OK);

				}
			} else {
				result =  new ResponseEntity<String>("noLogin", HttpStatus.CONFLICT);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result =  new ResponseEntity<String>("error", HttpStatus.CONFLICT);
		}
		return result;
	}
	@RequestMapping(value="/etc/isLogin", method = RequestMethod.POST)
	public ResponseEntity<String> isLogin(HttpServletRequest request) {
		ResponseEntity<String> result = new ResponseEntity<String>("noLogin", HttpStatus.OK);
		if(request.getSession().getAttribute("loginMember") != null) {
			result = new ResponseEntity<String>("login", HttpStatus.OK);
		}
		return result;
	}
}

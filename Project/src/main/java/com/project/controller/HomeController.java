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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.service.kjs.upload.UploadFileService;
import com.project.service.kjy.ListService;
import com.project.service.kjy.LoginService;
import com.project.service.kjy.NoticeService;
import com.project.service.kjy.UploadFileServiceNotuf;
import com.project.vodto.Board;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Memberkjy;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private UploadFileServiceNotuf fileService;
	
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
	public void notice(Model model) {
		try {
			List<Board> boardList = noticeService.getNotice();
			model.addAttribute("list", boardList);
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
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("/etc/writeNotice")
	public void writeNotice() {
		
	}
	
	@RequestMapping(value="/etc/uploadImage", method = RequestMethod.POST)
	public ResponseEntity<UploadFiles> uploadImage(@RequestParam("image") MultipartFile image, HttpServletRequest request) {
		ResponseEntity<UploadFiles> result = null;
		List<UploadFiles> fileList = new ArrayList<UploadFiles>();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		System.out.println("리얼패쓰"+realPath);
		try {
			fileList.add(fileService.uploadFile(image.getOriginalFilename(), image.getSize(), image.getBytes(), image.getContentType(), realPath));
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
				model.setViewName("redirect:/etc/writeNotice");
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
	public void readBoard(@RequestParam("no")int no, Model model) {
		try {
			Board board = noticeService.getNoticeByNo(no);
			model.addAttribute("board", board);
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
}

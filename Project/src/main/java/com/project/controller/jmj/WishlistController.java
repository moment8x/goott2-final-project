package com.project.controller.jmj;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.kjy.ListService;
import com.project.service.member.MemberService;
import com.project.vodto.jmj.SelectWishlist;
import com.project.vodto.kjy.Memberkjy;

@Controller
@RequestMapping("/wish/*")
public class WishlistController {
	@Inject 
	private ListService lService;
	@Inject 
	private MemberService mService;
	
	@RequestMapping(value = "likeProduct", method = RequestMethod.POST)
	public ResponseEntity<String> likeProduct(@RequestParam("productId") String productId, HttpServletRequest request, Model model) {
		System.out.println(productId + "번 상품 찜@@");
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		ResponseEntity<String> result = null;

		try {
			if(lService.insertlikeProduct(memberId, productId)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);	
			}
			
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail", HttpStatus.CONFLICT);	
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "disLikeProduct", method = RequestMethod.POST)
	public void disLikeProduct(@RequestParam("productId") String productId, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		try {
			if(lService.deleteWishList(memberId, productId)) {
				System.out.println(productId + "번 상품 찜 삭제 완룡");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}

package com.project.controller.kjs;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.project.controller.HomeController;
import com.project.service.kjs.shoppingcart.ShoppingCartService;
import com.project.vodto.Member;
import com.project.vodto.kjs.DisPlayedProductDTO;

/**
 * @author goott1
 * @packageName : com.project.controller.kjs
 * @fileName : ShoppingCartController.java
 * @date : 2023. 10. 13.
 * @description :
 */
@RestController
@RequestMapping("/shoppingCart/*")
public class ShoppingCartController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private ShoppingCartService scService;
	
	@RequestMapping("shoppingCart")
	public ModelAndView moveShoppingCart() {
		System.out.println("======= 장바구니 컨트롤러 - 장바구니 페이지로 이동 =======");
		ModelAndView mav = new ModelAndView("shoppingCart/shoppingCart");
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		
		return mav;
	}
	
	@RequestMapping("shoppingCart/all")
	public ResponseEntity<Map<String, Object>> shoppingCartList(HttpServletRequest request) {
		System.out.println("======= 장바구니 컨트롤러 - 장바구니 내역 불러오기 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		Map<String, Object> list = null;
		try {
			if (session.getAttribute("loginMember") != null) {
				// 로그인을 했으면
				Member member = (Member) session.getAttribute("loginMember");
				list = scService.getShoppingCart(member.getMemberId(), true);
				List<DisPlayedProductDTO> items = (List<DisPlayedProductDTO>)list.get("items");
				result = output(list, items);
			} else {
				// 로그인을 안했으면(비회원이면)			
				Cookie cookie = WebUtils.getCookie(request, "nom");
				if (cookie != null) {
					list = scService.getShoppingCart(cookie.getValue(), false);
					List<DisPlayedProductDTO> items = (List<DisPlayedProductDTO>)list.get("items");
					result = output(list, items);
				} // else : 타이밍 맞게 쿠키 유효기간이 지나 삭제됐을 경우
			}			
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			map.put("status", "error");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	private ResponseEntity<Map<String,Object>> output(Map<String, Object> list, List<DisPlayedProductDTO> items) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (items != null && items.size() > 0) {
			map.put("items", items);
			map.put("status", "success");
		}
		else {
			map.put("status", "none");
		}
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value="{productId}", method=RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteItem(HttpServletRequest request, @PathVariable("productId") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템(1개) 삭제 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		
		try {				
			if (session.getAttribute("loginMember") != null) {
				// 로그인을 했으면
				if (scService.deleteItem(((Member)session.getAttribute("loginMember")).getMemberId(), true, productId)) {
					map.put("status", "success");
					result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
				}
			} else {
				// 비회원이면
				Cookie cookie = WebUtils.getCookie(request, "nom");
				System.out.println("id : " + cookie.getValue() + ", productId : " + productId);
				if (cookie != null) {
					// 하나 이상의 row가 삭제되었다면
					if (scService.deleteItem(cookie.getValue(), false, productId)) {
						map.put("status", "success");
					}
					else {
						map.put("status", "fail");
					}
					result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
				}
			}
		} catch (SQLException | NamingException e) {
			map.put("status", "fail");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		
		return result;
	}
	
	// 체크된 items 삭제
	@RequestMapping(value="items", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCheckedItems(HttpServletRequest request, @RequestParam(value="items[]") List<String> items) {
		System.out.println("장바구니 컨트롤러 - 선택된 아이템 삭제");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("items : " + items);
		// 로그인 여부 확인
		// 로그인을 했으면
		
		// 비회원이면 
		Cookie cookie = WebUtils.getCookie(request, "nom");
		if (cookie != null) {
			try {
				if(scService.dellteItems(cookie.getValue(), false, items)) {
					map.put("status", "success");
				} else {
					map.put("status", "fail");
				}
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} catch (SQLException | NamingException e) {
				map.put("status", "fail");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
				e.printStackTrace();
			}
		}
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		
		return result;
	}
	
	// item 추가
	@RequestMapping("insert")
	public ResponseEntity<Map<String, Object>> addProduct(HttpServletRequest request, @RequestParam("product_id") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템 추가 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String,Object> map = new HashMap<String, Object>();
		
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		try {
			if (session.getAttribute("loginMember") != null) {
				// 로그인 했을 시
				if (scService.insertItem(((Member)session.getAttribute("loginMember")).getMemberId(), true, productId)) {
					map.put("status", "success");
				} else {
					// 이미 담긴 상품일 시
					map.put("status", "exist");
				}
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} else {
				// 비회원일 시
				Cookie cookie = WebUtils.getCookie(request, "nom");
				if (cookie != null) {
					if (scService.insertItem(cookie.getValue(), false, productId)) {
						map.put("status", "success");
					} else {
						// 이미 담긴 상품일 시
						map.put("status", "exist");
					}
					result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
				}
			}
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			map.put("status", "fail");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
//		String history = request.getHeader("referer");
//		history = history.substring(history.indexOf("/") + 2);
//		history = history.substring(history.indexOf("/"));
//		System.out.println("history path : " + history);
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	// 결제페이지에 데이터 넘기기
	public void orderPage(HttpServletRequest request) {
		System.out.println("======= 장바구니 컨트롤러 - 결제페이지 이동 =======");
		
		
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
	}
}
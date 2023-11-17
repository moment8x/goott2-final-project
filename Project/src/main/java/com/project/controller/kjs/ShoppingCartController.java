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
import com.project.vodto.kjs.ShowCartDTO;
import com.project.vodto.kjy.Memberkjy;

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
				Memberkjy member = (Memberkjy) session.getAttribute("loginMember");
				list = scService.getShoppingCart(member.getMemberId(), true);
				result = output(list);
			} else {
				// 로그인을 안했으면(비회원이면)			
				Cookie cookie = WebUtils.getCookie(request, "nom");
				if (cookie != null) {
					list = scService.getShoppingCart(cookie.getValue(), false);
					result = output(list);
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
	
	private ResponseEntity<Map<String,Object>> output(Map<String, Object> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (list != null) {
			if (list.get("items") != null) {
				map.put("list", list);
				map.put("status", "success");
			}
			else {
				map.put("status", "none");
			}
		}
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	@RequestMapping(value="{productId}", method=RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteItem(HttpServletRequest request, @PathVariable("productId") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템(1개) 삭제 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		List<ShowCartDTO> items = null;
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		
		try {				
			if (session.getAttribute("loginMember") != null) {
				// 로그인을 했으면
				if (scService.deleteItem(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true, productId)) {
					if (scService.countList(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true) > 0) {
						items = scService.getCartList(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true);
						map.put("cartItems", items);
					} else {
						map.put("cartItems", "none");
					}
					map.put("status", "success");
					result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
				}
			} else {
				// 비회원이면
				Cookie cookie = WebUtils.getCookie(request, "nom");
				if (cookie != null) {
					// 하나 이상의 row가 삭제되었다면
					if (scService.deleteItem(cookie.getValue(), false, productId)) {
						if (scService.countList(cookie.getValue(), false) > 0) {
							items = scService.getCartList(cookie.getValue(), false);
							map.put("cartItems", items);
						} else {
							map.put("cartItems", "none");
						}
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
	public ResponseEntity<Map<String, Object>> addProduct(HttpServletRequest request, 
			@RequestParam("product_id") String productId, @RequestParam("quantity") int quantity) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템 추가 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String,Object> map = new HashMap<String, Object>();
		
		// 로그인 여부 확인
		HttpSession session = request.getSession();
		try {
			if (session.getAttribute("loginMember") != null) {
				// 로그인 했을 시
				if (scService.insertItem(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true, productId, quantity)) {
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
					if (scService.insertItem(cookie.getValue(), false, productId, quantity)) {
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
	
	// 상품 qty update
	@RequestMapping(value="updateQTY", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> updateQTY(HttpServletRequest request, @RequestParam("productId") String productId, 
			@RequestParam("quantity") int quantity) {
		System.out.println("======= 장바구니 컨트롤러 - 장바구니 수량 변경 =======");
		System.out.println("productId : " + productId);
		System.out.println("quantity : " + quantity);
		ResponseEntity<Map<String, String>> result = null;
		Map<String, String> map = new HashMap<String, String>();
		HttpSession session = request.getSession();
		
		try {
			if (session.getAttribute("loginMember")!= null) {
				if (scService.updateQTY(((Memberkjy)session.getAttribute("loginMember")).getMemberId(), true, productId, quantity) == 1) {
					map.put("status", "success");
				} else {
					map.put("status", "problem");
				}
			} else {
				Cookie cookie = WebUtils.getCookie(request, "nom");
				if (cookie != null) {
					if (scService.updateQTY(cookie.getValue(), false, productId, quantity) == 1) {
						map.put("status", "success");
					} else {
						map.put("status", "problem");
					}
				}
			}
			result = new ResponseEntity<Map<String,String>>(map, HttpStatus.OK);
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			map.put("status", "fail");
			result = new ResponseEntity<Map<String,String>>(map, HttpStatus.BAD_REQUEST);
		}
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
}
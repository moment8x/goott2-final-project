package com.project.controller.kjs;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.project.controller.HomeController;
import com.project.service.kjs.shoppingcart.ShoppingCartService;
import com.project.vodto.Product;

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
	
	
	/**
	 * @MethodName : shoppingCartList
	 * @author : goott1
	 * @param model
	 * @param request
	 * @returnType : void
	 * @description : 장바구니 컨트롤러 - 내역 불러오기
	 * @date : 2023. 10. 13.
	 */
	@RequestMapping("shoppingCart/all")
	public ResponseEntity<Map<String, Object>> shoppingCartList(HttpServletRequest request) {
		System.out.println("======= 장바구니 컨트롤러 - 장바구니 내역 불러오기 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 로그인 여부 확인
		// 로그인을 했으면
		try {
			Map<String, Object> list = null;
			
			//scService.getShoppingCart(null, true);
			
			// 로그인을 안했으면(비회원이면)
			Cookie cookie = WebUtils.getCookie(request, "nom");
			if (cookie != null) {
				list = scService.getShoppingCart(cookie.getValue(), false);
				// 해당 비회원의 상품 장바구니 List
//				List<ShoppingCart> cartList = (List<ShoppingCart>)list.get("list");
				// 장바구니 List에 담긴 상품의 정보
				List<Product> items = (List<Product>)list.get("items");
//				model.addAttribute("cartList", cartList);
				if (items != null && items.size() > 0) {
					map.put("items", items);
					map.put("status", "success");
				}
				else {
					map.put("status", "none");
				}
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} // else : 타이밍 맞게 쿠키 유효기간이 지나 삭제됐을 경우
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
			map.put("status", "error");
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	/**
	 * @MethodName : deleteItem
	 * @author : goott1
	 * @param request
	 * @param productId
	 * @return
	 * @returnType : ResponseEntity<Map<String,Object>>
	 * @description : 장바구니 컨트롤러 - 아이템(1개) 삭제
	 * @date : 2023. 10. 13.
	 */
	@RequestMapping(value="{productId}", method=RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteItem(HttpServletRequest request, @PathVariable("productId") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템(1개) 삭제 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 로그인 여부 확인
		// 로그인을 했으면
		
		// 비회원이면
		Cookie cookie = WebUtils.getCookie(request, "nom");
		System.out.println("id : " + cookie.getValue() + ", productId : " + productId);
		if (cookie != null) {
			try {				
				// 하나 이상의 row가 삭제되었다면
				if (scService.deleteItem(cookie.getValue(), false, productId)) {
					map.put("status", "success");
				}
				else {
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
	@RequestMapping(value="{productId}", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addProduct(HttpServletRequest request, @PathVariable("productId") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템 추가 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String,Object> map = new HashMap<String, Object>();
		// 로그인 여부 확인
		// 로그인 했을 시
		
		// 비회원일 시
		Cookie cookie = WebUtils.getCookie(request, "nom");
		if (cookie != null) {
			try {
				scService.insertItem(cookie.getValue(), false, productId);
				map.put("status", "success");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
			} catch (SQLException | NamingException e) {
				e.printStackTrace();
				map.put("status", "fail");
				result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
			}
		}
		
//		String history = request.getHeader("referer");
//		history = history.substring(history.indexOf("/") + 2);
//		history = history.substring(history.indexOf("/"));
//		System.out.println("history path : " + history);
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	@RequestMapping("/insert")
	public ResponseEntity<String> test(@RequestParam("product_id") String id){
		System.out.println(id + "장바구니 들어옴");
		return ResponseEntity.ok("Success");
	}
}
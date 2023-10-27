package com.project.controller.kjs;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
@Controller
@RequestMapping("/shoppingCart/*")
public class ShoppingCartController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	ShoppingCartService scService;
	
	/**
	 * @MethodName : shoppingCartList
	 * @author : goott1
	 * @param model
	 * @param request
	 * @returnType : void
	 * @description : 장바구니 컨트롤러 - 장바구니 조회
	 * @date : 2023. 10. 13.
	 */
	@RequestMapping("shoppingCart")
	public void shoppingCartList(Model model, HttpServletRequest request) {
		System.out.println("======= 장바구니 컨트롤러 - 장바구니 조회 =======");
		// 로그인 여부 확인
		// 로그인을 했으면
		try {
			Map<String, Object> list = null;
			
			scService.getShoppingCart(null, true);
			// 로그인을 안했으면(비회원이면)
			Cookie cookie = WebUtils.getCookie(request, "nom");
			if (cookie != null) {
				list = scService.getShoppingCart(cookie.getValue(), false);
				// 해당 비회원의 상품 장바구니 List
//				List<ShoppingCart> cartList = (List<ShoppingCart>)list.get("list");
				// 장바구니 List에 담긴 상품의 정보
				List<Product> items = (List<Product>)list.get("items");
//				model.addAttribute("cartList", cartList);
				model.addAttribute("items", items);
			} // else : 타이밍 맞게 쿠키 유효기간이 지나 삭제됐을 경우
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
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
	@RequestMapping(value="delItem", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteItem(HttpServletRequest request, @RequestParam("productId") String productId) {
		System.out.println("======= 장바구니 컨트롤러 - 아이템(1개) 삭제 =======");
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> list = null;
		// 로그인 여부 확인
		// 로그인을 했으면
		
		// 비회원이면
		Cookie cookie = WebUtils.getCookie(request, "nom");
		if (cookie != null) {
			try {				
				// 하나 이상의 row가 삭제되었다면
				if (scService.deleteItem(cookie.getValue(), false, productId)) {
					// 새로운 List를 받아옴
					list = scService.getShoppingCart(cookie.getValue(), false);
					List<Product> items = (List<Product>)list.get("items");
					map.put("items", items);
					map.put("status", "success");
				}
				else {
					map.put("status", "fail");
				}
			} catch (SQLException | NamingException e) {
				map.put("status", "fail");
				e.printStackTrace();
			}
		}
		result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		
		return result;
	}
	
	// 체크된 items 삭제
	@RequestMapping(value="delItems", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCheckedItems() {
		System.out.println("장바구니 컨트롤러 - 선택된 아이템 삭제");
		ResponseEntity<Map<String, Object>> result = null;
		// 여기부터 해야 함
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	// item 추가
	@RequestMapping("addShoppingCart")
	public String addProduct(HttpServletRequest request, @RequestParam("product_id") String productId) {
		System.out.println("장바구니 컨트롤러 - 아이템 추가");
		String result = "";
		
		System.out.println("======= 장바구니 컨트롤러단 끝 =======");
		return result;
	}
	
	@RequestMapping(value="/insert" ,  method=RequestMethod.POST)
	public ResponseEntity<String> test(@RequestParam("id") String id){
		System.out.println(id + "야이야이야 내나이가 어때서");
		return ResponseEntity.ok("Success");
	}
}
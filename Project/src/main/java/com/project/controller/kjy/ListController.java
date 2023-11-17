package com.project.controller.kjy;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.service.kjy.ListService;
import com.project.vodto.PagingInfo;
import com.project.vodto.Product;
import com.project.vodto.kjy.Memberkjy;
import com.project.vodto.kjy.ProductCategories;
import com.project.vodto.kjy.Products;
import com.project.vodto.kjy.SearchVO;

@Controller
@RequestMapping("/list/*")
public class ListController {
	private String sortBy = "new";
	private int page = 1;
	@Inject
	private ListService lService;
	
	private static final Logger logger = LoggerFactory.getLogger(ListController.class);
	
	@RequestMapping("/category/{lang}")
	public String goCategory(Model model, @PathVariable String lang) {
		// 리스트 카테고리 가져오기 + 현재 페이지 정보
		try {
			List<ProductCategories> lst = lService.getProductCategory(lang+"/");
			ProductCategories pd = lService.getCategoryInfo(lang);
			System.out.println("pd"+pd +"lst"+lst);
			List<Products> bestSellers = lService.getProductsBsetSeller(lang);
			model.addAttribute("categories", lst);
			model.addAttribute("nowCategory", pd);
			model.addAttribute("bestSellers", bestSellers);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("lang", lang);
		return "list/category";
	}
	
	@RequestMapping("/categoryList/{lang}/{key}")
	public String goList(Model model, @PathVariable(name="key") String key, @RequestParam(value="page", defaultValue = "1") int page,@RequestParam(value="active", defaultValue = "grid-btn d-xxl-inline-block d-none") String active, @PathVariable(name="lang") String lang, HttpServletRequest request) {
		this.page = page;
		String categoryKey = lang + "/" + key; 
		
		
		// 상위 분류 페이지 + 현재 페이지 정보
		try {
			ProductCategories categoryLanguage = lService.getCategoryInfo(lang);
			ProductCategories nowCategory = lService.getCategoryInfo(categoryKey);;
			model.addAttribute("categoryLang", categoryLanguage);
			model.addAttribute("nowCategory", nowCategory);
			model.addAttribute("key", categoryKey);
			model.addAttribute("page", page);
			model.addAttribute("active", active);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// 카테고리 목록 가져오기
		try {
			List<ProductCategories> lstPC= lService.getProductCategory(categoryKey);
			if (lstPC != null) { 
				model.addAttribute("productCategory", lstPC);
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("productCategory", "fail");
		}
		
		// 상품 가져오기
		try {
			Map<String, Object> map = lService.getProductForList(categoryKey, page, sortBy);
			List<Products> lst = (List<Products>)map.get("list_product");
			System.out.println("리스트는"+lst);
			PagingInfo paging = (PagingInfo)map.get("paging_info");
			model.addAttribute("products", lst);
			model.addAttribute("paging_info", paging);
			model.addAttribute("sortBy", sortBy);		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("products", "fail");
		}
		
		return "/list/categoryList";
	}
	@RequestMapping("/sort")
	public ResponseEntity<Map<String, Object>> getSort(Model model, @RequestParam("key") String key, @RequestParam("sortBy") String sortBy) {
		this.sortBy = sortBy;
		ResponseEntity<Map<String, Object>> result = null;
		try {
			Map<String, Object> map = lService.getProductForList(key, page, sortBy);
			
			result = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<Map<String,Object>>(HttpStatus.CONFLICT);
		}
		
		return result;
	}
	@RequestMapping("/isLogin")
	public ResponseEntity<Map<String, String>> checkLogin(HttpServletRequest request){
		ResponseEntity<Map<String, String>> data = null;
		Map<String, String> loginMap = new HashMap<String, String>();
		if(request.getSession().getAttribute("loginMember") != null) {
			loginMap.put("isLogin", "loginOK");
			data = new ResponseEntity<Map<String,String>>(loginMap, HttpStatus.OK);
		} else {
			loginMap.put("isLogin", "noLogin");
			data = new ResponseEntity<Map<String,String>>(loginMap, HttpStatus.OK);
		}
		return data;
	}
	
	@RequestMapping(value = "/float", method = RequestMethod.POST)
	public ResponseEntity<Products> getProduct(@RequestParam("id") String id){
		ResponseEntity<Products> res = null;
		try {
			Products products = lService.getProductById(id);
			res = new ResponseEntity<Products>(products, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			res = new ResponseEntity<Products>(HttpStatus.CONFLICT);
			e.printStackTrace();
		}
		return res;
		
	}
	@RequestMapping("/searchPage")
	public Model goSearching(@RequestParam(value="val", defaultValue = "notSearch") String val,
			@RequestParam(value="page", defaultValue = "1") int page, 
			@RequestParam(value="sort", defaultValue = "aToz") String sort, Model model) {
		if("notSearch".equals(val)) {
			model.addAttribute("products", val);
		} else {
			naverBookSearch(val);
			try {
				// 검색에 해당하는 상품 가져오기
				Map<String, Object> map = lService.searchProducts(val, sort, page);
				// 검색에 해당하는 카테고리 정보 가져오기
				List<SearchVO> listCategoryies = lService.searchProductsCateogries(val);
				// 검색에 해당하는 언어 정보 가져오기
				List<Integer> listLangInt = lService.searchProductslang(val);
				List<Products> lst = (List<Products>) map.get("pList");
				PagingInfo paging = (PagingInfo) map.get("paging");
				model.addAttribute("products", lst);
				model.addAttribute("categories", listCategoryies);
				model.addAttribute("lang", listLangInt);
				model.addAttribute("paging", paging);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return model;
	}
	
	private void naverBookSearch(String val) {
		String baseUrl = "https://openapi.naver.com/v1/search/book.json";
		// 검색어
		String query = "?query=val";
		// 보여줄 상품 개수
		String display = "&display=10";
		String sort = "&sort=sim";
		String bookUrl = baseUrl + query + display + sort;
		try {
			URLEncoder.encode(bookUrl, "UTF-8");
			URL url = new URL(bookUrl);
			HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("X-Naver-Client-Id", "QvibsLi5PSZRGzsKS_Zp");
			conn.setRequestProperty("X-Naver-Client-Secret", "o6h8h8IDEQ");
			int responseCode = conn.getResponseCode();
			
			if(responseCode == 200) {
				 BufferedReader bookReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                 StringBuilder bookResponse = new StringBuilder();
                 String bookInputLine;
                 while ((bookInputLine = bookReader.readLine()) != null) {
                	 bookResponse.append(bookInputLine);
                 }
                 bookReader.close(); 
                 
               ObjectMapper objectMapper = new ObjectMapper();
               JsonNode jsonMapper = new ObjectMapper().readTree(bookResponse.toString());
//               objectMapper.treeToValue(jsonMapper, null);
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="/searchPageWithFilter", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> productListWithFilter(@RequestParam(value ="val", defaultValue = "notSearch") String val,
			@RequestParam(value = "checkedList[]", defaultValue = "") List<String> checkedList,
			@RequestParam(value = "checkedLang[]", defaultValue = "") List<String> checkedLang,
			@RequestParam(value = "sort", defaultValue = "aToz") String sort,
			@RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		ResponseEntity<Map<String, Object>> mapJson = null;
		try {
			Map<String, Object> map = lService.searchProductsWithFilter(val, checkedList, checkedLang, sort, page);
			mapJson = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mapJson = new ResponseEntity<Map<String, Object>>(HttpStatus.CONFLICT);
		}
		
		
		return mapJson;
	}
}

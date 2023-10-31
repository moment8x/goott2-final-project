package com.project.controller.kjy;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.Console;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.service.kjy.ListService;
import com.project.vodto.PagingInfo;
import com.project.vodto.Product;
import com.project.vodtokjy.ProductCategories;
import com.project.vodtokjy.Products;

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
			List<ProductCategories> lst = lService.getProductCategory(lang);
			ProductCategories pd = lService.getCategoryInfo(lang);
			model.addAttribute("categories", lst);
			model.addAttribute("nowCategory", pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("lang", lang);
		return "list/category";
	}
	
	@RequestMapping("/categoryList/{lang}/{key}")
	public String goList(Model model, @PathVariable(name="key") String key, @RequestParam(value="page", defaultValue = "1") int page, @PathVariable(name="lang") String lang) {
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
			List<Product> lst = (List<Product>)map.get("list_product");
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
}

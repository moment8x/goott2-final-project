package com.project.controller.kjs;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.kjs.detail.ProductDetailService;
import com.project.vodto.Product;
import com.project.vodto.kjs.ProductImage;

@Controller
@RequestMapping("/detail/*")
public class ProductDetailController {
   
	@Inject
	private ProductDetailService pdService;  // Product 객체 주입
    
    @RequestMapping("{productId}")
	public String getDetailPage(@PathVariable("productId") String productId, Model model, HttpServletRequest req) throws Exception {
		System.out.println("======= 상품 상세정보 컨트롤러 - 상품코드 " + productId + " 조회 =======");
		
		// 이미지 정보를 제외한 product info
		Product product = pdService.getProductInfo(productId);
		// 해당 productId에 맞는 이미지 정보
		List<ProductImage> productImage = pdService.getProductImages(productId);
		
		model.addAttribute("product", product);
		model.addAttribute("productImages", productImage);
		
		System.out.println("======= 상품 상세정보 컨트롤러 종료 =======");
		return "detail";
    }
}
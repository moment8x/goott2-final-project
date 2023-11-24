package com.project.controller.kjs;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.kjs.detail.ProductDetailService;
import com.project.service.kjs.review.ReviewService;
import com.project.vodto.PagingInfo;
import com.project.vodto.kjs.DisPlayedProductDTO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjs.ReviewBoardDTO;

@Controller
@RequestMapping("/detail/*")
public class ProductDetailController {
   
	@Inject
	private ProductDetailService pdService;
	@Inject
	private ReviewService rService;
    
    @RequestMapping("{productId}")
	public String getDetailPage(@PathVariable("productId") String productId, @RequestParam(value="page", defaultValue = "1") int page, Model model, HttpServletRequest req) throws Exception {
		
		// 이미지 정보를 제외한 product info
    	DisPlayedProductDTO product = pdService.getProductInfo(productId);
    	// 해당 product의 카테고리 정보
    	List<String> categories = pdService.getCategory(product.getCategoryKey());
		// 해당 productId에 맞는 이미지 정보
		List<ProductImage> productImage = pdService.getProductImages(productId);
		// 해당 productId로 리뷰글 조회
		Map<String, Object> map = rService.getReviewList(productId, page);
		
		@SuppressWarnings("unchecked")
		List<ReviewBoardDTO> reviewList = (List<ReviewBoardDTO>)map.get("reviewList");
		PagingInfo pagingInfo = (PagingInfo)map.get("pagingInfo");
		
		model.addAttribute("product", product);
		model.addAttribute("productImages", productImage);
		model.addAttribute("categories", categories);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pagingInfo", pagingInfo);
		
		return "detail";
    }
}
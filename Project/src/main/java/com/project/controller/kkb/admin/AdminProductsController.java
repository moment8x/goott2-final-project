package com.project.controller.kkb.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.AdminProductsService;
import com.project.service.kjy.UploadFileServiceKjy;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.AdminProductsSearchVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.ProductImage;
import com.project.vodto.kjy.Categories;
import com.project.vodto.kjy.Products;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/products")
public class AdminProductsController {
	
	private final AdminProductsService adminProductsService;
	
	// ----------------------------- 김상희 -----------------------------
	@GetMapping("/dashBoardMain")
	public Map<String, Object> getAllPrdoctsCount() {
		Map<String, Object> result = adminProductsService.getAllProductsCount();
		return result;
	}
	
	@GetMapping("/productManage")	// 모든 상품 조회(판매중인 상품은 쿼리스트링으로 받아서)
	public Map<String, Object> getAllPrducts(
			@RequestParam String searchKey,
			@RequestParam String searchValue,
			@RequestParam String categoryKey,
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam(defaultValue = "2") byte bestSellerStatus)
			/*@RequestParam String sellingProducts)*/ {
		
		AdminProductsSearchVO search = AdminProductsSearchVO.create(searchKey, searchValue, categoryKey, startDate, endDate, bestSellerStatus);
		System.out.println("search : " + search.toString());
		return adminProductsService.getAllProducts(search);
	}
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	private final UploadFileServiceKjy fileServiceNotuf;
	
	@ResponseBody
	@RequestMapping("/getAllProducts")
	public List<Products> getPrdouctsFroAdmin(){
		List<Products> list = null;
		try {
			list = adminProductsService.getProductsForAdmin();
			for(Products p : list) {
				p.setAuthorIntroduction(p.getAuthorIntroduction().replaceAll("<br>", "\r\n"));
				p.setIntroductionIntro(p.getIntroductionIntro().replaceAll("<br>", "\r\n"));
				p.setIntroductionDetail(p.getIntroductionDetail().replaceAll("<br>", "\r\n"));
				p.setTableOfContents(p.getTableOfContents().replaceAll("<br>", "\r\n"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/getCategories")
	public List<Categories> getProductCategoriesForAdmin(@RequestParam(value="key", defaultValue = "KOR")String key) {
		List<Categories> categories = null;
		if(!key.equals("")) {
			try {
				categories = adminProductsService.getCategoriesForAdmin(key);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return categories;
	}
	
	@ResponseBody
	@PostMapping("/inputProducts")
	public String inputProductForAdmin(@RequestPart Products products,
			@RequestPart(name="images") List<MultipartFile> images, HttpServletRequest request) {
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!");
		String result = "";
		
		if(products.getAuthorIntroduction() != null) {			
			products.setAuthorIntroduction(products.getAuthorIntroduction().replaceAll("\r\n", "<br>"));
		}
		if(products.getIntroductionIntro() != null) {			
			products.setIntroductionIntro(products.getIntroductionIntro().replaceAll("\r\n", "<br>"));
		}
		if(products.getIntroductionDetail() != null) {			
			products.setIntroductionDetail(products.getIntroductionDetail().replaceAll("\r\n", "<br>"));
		}
		if(products.getTableOfContents() != null) {			
			products.setTableOfContents(products.getTableOfContents().replaceAll("\r\n", "<br>"));
		}	 	
		
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		System.out.println("리얼패쓰 : " + realPath);
		
		List<UploadFiles> uploadFiles = new ArrayList<UploadFiles>();
		if(images != null && images.size() > 0) {
			for(MultipartFile image : images) {
			String orginalFileName = image.getOriginalFilename();
			System.out.println("images : "  + orginalFileName);
			Long size = image.getSize();
			String contentType = image.getContentType();
				try {
					byte[] imageByte = image.getBytes();
					uploadFiles.add(fileServiceNotuf.uploadFileKjy(orginalFileName, size, imageByte, contentType, realPath));
					if(adminProductsService.inputProductsForAdmin(products, uploadFiles)) {
						result = "저장에 성공하셨습니다.";
					} else {
						result = "저장에 실패하셨습니다.";
					}
				} catch (Exception e) {
					e.printStackTrace();
						result = "에러";
				}
				System.out.println(uploadFiles);
			}	
		} else {
			result = "이미지가 없습니다.";
		}
		
		return result;
	}
	
	@ResponseBody
	@PutMapping("/update")
	public String changeProductForAdmin(@RequestBody Products products, HttpServletRequest request) {
		String result = "";
		
		if(products.getAuthorIntroduction() != null) {			
			products.setAuthorIntroduction(products.getAuthorIntroduction().replaceAll("\r\n", "<br>"));
		}
		if(products.getIntroductionIntro() != null) {			
			products.setIntroductionIntro(products.getIntroductionIntro().replaceAll("\r\n", "<br>"));
		}
		if(products.getIntroductionDetail() != null) {			
			products.setIntroductionDetail(products.getIntroductionDetail().replaceAll("\r\n", "<br>"));
		}
		if(products.getTableOfContents() != null) {			
			products.setTableOfContents(products.getTableOfContents().replaceAll("\r\n", "<br>"));
		}	
		try {
			if(adminProductsService.changeProductsForAdmin(products)) {
				result = "수정에 성공하였습니다.";
			} else {
				result = "수정에 실패하였습니다.";
			}
		} catch (Exception e) {
			e.printStackTrace();
				result = "에러가 발생하여 실패하였습니다.";
		}
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/getProductsImages")
	public List<ProductImage> getProductImages(@RequestParam("productId") String productId) {
		List<ProductImage> images = null;
		try {
			images = adminProductsService.getProductImagesForAdmin(productId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return images;
	}
	
	@ResponseBody
	@PostMapping("/insertProductImages")
	public String insertProductImage(@RequestPart(name="productImages") List<MultipartFile> images, @RequestParam("productId") String productId
			,HttpServletRequest request) {
		String result = "";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		
		List<UploadFiles> uploadFiles = new ArrayList<UploadFiles>();
		if(images != null && images.size() > 0) {
			for(MultipartFile image : images) {
			String orginalFileName = image.getOriginalFilename();
			System.out.println("images : "  + orginalFileName);
			Long size = image.getSize();
			String contentType = image.getContentType();
				try {
					byte[] imageByte = image.getBytes();
					
					uploadFiles.add(fileServiceNotuf.uploadFileKjy(orginalFileName, 0, imageByte, contentType, realPath));
					
				} catch (Exception e) {
					e.printStackTrace();
						result = "에러";
				}
				System.out.println(uploadFiles);
			}	
			System.out.println("@@@@@@@@@@@@"+uploadFiles);
			try {
				if(adminProductsService.inputProductImagesForAdmin(productId, uploadFiles)) {
					result = "저장에 성공하셨습니다.";
				} else {
					result = "저장에 실패하셨습니다.";
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			result = "이미지가 없습니다.";
		}

		return result;
	}
	
	@ResponseBody
	@DeleteMapping("/deleteProductImage")
	public String removeProductImages(@RequestParam("productId") String productId, @RequestParam("newFileName") String newFileName,HttpServletRequest request) {
			String result = "";
			String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		try {
			if(adminProductsService.removeProductImagesForAdmin(productId, newFileName)) {
				if(fileServiceNotuf.deleteFile(newFileName, realPath) == 1) {
					result = "삭제 성공.";					
				} else {
					result = "삭제에 실패하셨습니다.";
				}
			} else {
				result = "DB 삭제에 실패하셨습니다.";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = "에러";
		}
		return result;
	}
	
	@ResponseBody
	@DeleteMapping("/deleteProducts")
	public String removeProductImages(@RequestParam("productId")String productId, HttpServletRequest request) {
		String result = "";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/productImages");
		try {
			List<ProductImage> images = adminProductsService.removeProductForAdmin(productId);
			if(images != null) {
				for(ProductImage image : images) {
					if(fileServiceNotuf.deleteFile(image.getProductImage(), realPath) == 1) {
						result = "상품 정보 삭제 완료.";
					} else {
						result = "경로에 저장된 이미지 삭제 실패.";
					}
				}
			} else {
				result = "상품 정보 삭제 실패.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "에러.";
		}
		return result;
	}
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	@GetMapping("/")
	public Map<String, Object> mainListPage() {
		System.out.println("상품 목록 조회");
		return adminProductsService.getStockList();
	}
	
	@GetMapping("/category/{categoryKey}")
	public Map<String, Object> selectedCategories(@PathVariable("categoryKey") String categoryCode) {
		System.out.println("카테고리 - 하위 카테고리 조회");
		return adminProductsService.getCategoryChild(categoryCode);
	}
	
	@GetMapping("/search")
	public Map<String, Object> searchProducts(
			@RequestParam String searchKey,
			@RequestParam String searchValue,
			@RequestParam String categoryKey,
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam(defaultValue = "2") byte bestSellerStatus
			) {
		/*
		검색 분류 - searchKey,	검색 분류의 값 - searchValue
		상품 분류 - category_code,	하위 분류 포함 검색 - child_category	(boolean)
		상품 등록일 - start_date, end_date
		
		
		Language,			언어
		major category,		대분류
		middle category,	중분류
		minor category		소분류
		*/
		AdminProductsSearchVO search = AdminProductsSearchVO.create(searchKey, searchValue, categoryKey, startDate, endDate, bestSellerStatus);
		return adminProductsService.getSearchStockList(search);
	}
	
	@PutMapping("/updateStock")
	public ResponseEntity<String> updateStock(@RequestBody List<AdminUpdateStockVO> updateStock) {
		System.out.println("재고량 변경 - controller");
		ResponseEntity<String> result = null;
		
		int i = adminProductsService.updateStock(updateStock);
		
		if (i > -1) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	@GetMapping("/soldout")
	public Map<String, Object> soldOutProducts() {
		System.out.println("품절 상품 조회");
		return adminProductsService.getSoldOutProducts();
	}
	// ----------------------------------------------------------------
}
package com.project.controller.kkb.admin;

import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.kkb.admin.AdminStatisticsService;
import com.project.vodto.kkb.StatisticsCond;

import lombok.RequiredArgsConstructor;

@CrossOrigin(origins = "*")  //http://localhost:5173
@RequiredArgsConstructor
@RestController
@RequestMapping("/admin/statistics")
public class AdminStatisticsController {
	
	private final AdminStatisticsService adminStatisticsService;
	
	/* 통계 대시보드 */
	@GetMapping("/dashboard")
	public Map<String, Object> searchOrderInfo(){
		return adminStatisticsService.getDashboardInfo();
	}

/* ----------------------- 매출 분석 -----------------------*/
	
	/* 일별 매출 */
	@GetMapping("/daily")
	public Map<String, Object> searchDailyReport(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getDaliyReport(statisticsCond);
	}
	
	/* 주별 매출 */
	@GetMapping("/weekly")
	public Map<String, Object> searchWeeklyReport(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getWeeklyReport(statisticsCond);
	}
	
	/* 월별 매출 */
	@GetMapping("/monthly")
	public Map<String, Object> searchMonthlyReport(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getMonthlyReport(statisticsCond);
	}
	
	/* 매출 집계(판매 이익) */
	@GetMapping("/revenue")
	public Map<String, Object> searchRevenueReport(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getRevenueReport(statisticsCond);
	}

/* ----------------------- 상품 분석 -----------------------*/	
	
	/* 판매 상품 순위 */
	@GetMapping("/products")
	public Map<String, Object> searchProductRanking(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getProductRanking(statisticsCond);
	}
	
	/* 판매 분류 순위 */
	@GetMapping("/categories")
	public Map<String, Object> searchCategoryRanking(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getCategoryRanking(statisticsCond);
	}
	
	/* 취소/반품 순위 */
	@GetMapping("/returns")
	public Map<String, Object> searchReturnRanking(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getReturnRanking(statisticsCond);
	}
	
	/* 장바구니 상품 분석 */
	@GetMapping("/cart")
	public Map<String, Object> searchCartInfo(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getCartInfo(statisticsCond);
	}
	
	/* 관심 상품 분석 */
	@GetMapping("/wishlist")
	public Map<String, Object> searchWishlistInfo(@RequestParam String dateStart,@RequestParam String dateEnd) {	
		StatisticsCond statisticsCond = StatisticsCond.create(dateStart, dateEnd);
		
		return adminStatisticsService.getWishlistInfo(statisticsCond);
	}

}

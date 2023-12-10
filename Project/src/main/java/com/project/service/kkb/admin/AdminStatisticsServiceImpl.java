package com.project.service.kkb.admin;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project.dao.kkb.admin.AdminStatisticsDAO;
import com.project.vodto.kkb.AggregateResponse;
import com.project.vodto.kkb.CategoryRankingResponse;
import com.project.vodto.kkb.ProductRankingResponse;
import com.project.vodto.kkb.RevenueResponse;
import com.project.vodto.kkb.StatisticsCond;
import com.project.vodto.kkb.UserStorageResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminStatisticsServiceImpl implements AdminStatisticsService {

	public final AdminStatisticsDAO adminStatisticsDAO;
	
	/* 통계 대시보드 */
	@Override
	public Map<String, Object> getDashboardInfo() {
		
		LocalDate todayDate = LocalDate.now();
		
		String today= todayDate.toString();
		String weekStart = todayDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)).toString();
		String lastMonthStart = todayDate.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth()).toString();
		String lastMonthEnd = todayDate.minusMonths(1).with(TemporalAdjusters.lastDayOfMonth()).toString();
		
		StatisticsCond todayTop10 = StatisticsCond.create(today, today, 10);
		StatisticsCond weekTop5Quantity = StatisticsCond.create(weekStart, today, 5, false);
		StatisticsCond weekTop5Rate = StatisticsCond.create(weekStart, today, 5, true);
		StatisticsCond lastMonthTop5 = StatisticsCond.create(lastMonthStart, lastMonthEnd, 5);
		
		List<ProductRankingResponse> productRankingTop10 = adminStatisticsDAO.findProductRanking(todayTop10);
		List<UserStorageResponse> cartRankingTop10 = adminStatisticsDAO.findCartInfo(todayTop10);
		List<ProductRankingResponse> returnRankingTop5Quantity = adminStatisticsDAO.findReturnRanking(weekTop5Quantity);
		List<ProductRankingResponse> returnRankingTop5Rate = adminStatisticsDAO.findReturnRanking(weekTop5Rate);
		List<CategoryRankingResponse> CategoryRankingLastMonthTop5 = adminStatisticsDAO.findCategoryRanking(lastMonthTop5);
		
		Map<String, Object> result = new HashMap<>();
		result.put("productRankingTop10", productRankingTop10);
		result.put("cartRankingTop10", cartRankingTop10);
		result.put("returnRankingTop5Quantity", returnRankingTop5Quantity);
		result.put("returnRankingTop5Rate", returnRankingTop5Rate);
		result.put("CategoryRankingLastMonthTop5", CategoryRankingLastMonthTop5);
		
		return result;
	}

/* ----------------------- 매출 분석 -----------------------*/	
	
	/* 매출분석(일별 매출) */
	@Override
	public Map<String, Object> getDaliyReport(StatisticsCond statisticsCond) {
		
		List<RevenueResponse> daliyList = adminStatisticsDAO.findDaliyReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("daliyList", daliyList);
		
		return result;
	}

	/* 매출분석(주별 매출) */
	@Override
	public Map<String, Object> getWeeklyReport(StatisticsCond statisticsCond) {
		
		List<RevenueResponse> weeklyList = adminStatisticsDAO.findWeeklyReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("weeklyList", weeklyList);
		
		return result;
	}

	/* 매출분석(월별 매출) */
	@Override
	public Map<String, Object> getMonthlyReport(StatisticsCond statisticsCond) {
		
		List<RevenueResponse> monthList = adminStatisticsDAO.findMonthlyReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("monthList", monthList);
		
		return result;
	}

	/* 매출분석(매출 집계) */
	@Override
	public Map<String, Object> getRevenueReport(StatisticsCond statisticsCond) {
		
		List<AggregateResponse> RevenueList = adminStatisticsDAO.findRevenueReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("RevenueList", RevenueList);
		
		return result;
	}

/* ----------------------- 상품 분석 -----------------------*/
	
	/* 상품 분석(판매 상품 순위) */
	@Override
	public Map<String, Object> getProductRanking(StatisticsCond statisticsCond) {
		
		List<ProductRankingResponse> ProductRankingList = adminStatisticsDAO.findProductRanking(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("ProductRankingList", ProductRankingList);
		
		return result;
	}

	/* 상품 분석(판매 분류 순위) */
	@Override
	public Map<String, Object> getCategoryRanking(StatisticsCond statisticsCond) {
		
		List<CategoryRankingResponse> categoryRankingList = adminStatisticsDAO.findCategoryRanking(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("categoryRankingList", categoryRankingList);
		
		return result;
	}

	/* 상품 분석(취소/반품 순위) */
	@Override
	public Map<String, Object> getReturnRanking(StatisticsCond statisticsCond) {
		
		List<ProductRankingResponse> returnRankingList = adminStatisticsDAO.findReturnRanking(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("returnRankingList", returnRankingList);
		
		return result;
	}

	/* 상품 분석(장바구니 상품 분석) */
	@Override
	public Map<String, Object> getCartInfo(StatisticsCond statisticsCond) {
		
		List<UserStorageResponse> cartInfoList = adminStatisticsDAO.findCartInfo(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cartInfoList", cartInfoList);
		
		return result;
	}

	/* 상품 분석(관심 상품 분석) */
	@Override
	public Map<String, Object> getWishlistInfo(StatisticsCond statisticsCond) {
		
		List<UserStorageResponse> wishlistInfoList = adminStatisticsDAO.findWishlistInfo(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("wishlistInfoList", wishlistInfoList);
		
		return result;
	}

}

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
import com.project.vodto.kkb.BestSellerResponse;
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
		
		StatisticsCond todayTop10 = StatisticsCond.create(10, null, null);
		StatisticsCond weekTop5Quantity = StatisticsCond.create(weekStart, today, 5, false);
		StatisticsCond weekTop5Rate = StatisticsCond.create(weekStart, today, 5, true);
		StatisticsCond weekTop5 = StatisticsCond.create(weekStart, today, 5);
		StatisticsCond lastMonthTop5 = StatisticsCond.create(lastMonthStart, lastMonthEnd, 5);
		
		List<ProductRankingResponse> productRankingTop10 = adminStatisticsDAO.findProductRanking(todayTop10);
		List<UserStorageResponse> cartRankingTop10 = adminStatisticsDAO.findCartInfo(todayTop10);
		List<ProductRankingResponse> returnRankingTop5Quantity = adminStatisticsDAO.findReturnRanking(weekTop5Quantity);
		List<ProductRankingResponse> returnRankingTop5Rate = adminStatisticsDAO.findReturnRanking(weekTop5Rate);
		List<CategoryRankingResponse> categoryRankingLastMonthTop5 = adminStatisticsDAO.findCategoryRanking(lastMonthTop5);
		List<CategoryRankingResponse> categoryRankingWeeklyTop5 = adminStatisticsDAO.findCategoryRanking(weekTop5);
		List<BestSellerResponse> bestSellerList = adminStatisticsDAO.findBestSellerInfo();
		
		Map<String, Object> result = new HashMap<>();
		result.put("bestSellerList", bestSellerList);
		result.put("productRankingTop10", productRankingTop10);
		result.put("cartRankingTop10", cartRankingTop10);
		result.put("returnRankingTop5Quantity", returnRankingTop5Quantity);
		result.put("returnRankingTop5Rate", returnRankingTop5Rate);
		result.put("categoryRankingLastMonthTop5", categoryRankingLastMonthTop5);
		result.put("categoryRankingWeeklyTop5", categoryRankingWeeklyTop5);
		
		return result;
	}

/* ----------------------- 매출 분석 -----------------------*/	
	
	/* 매출분석(일별 매출) */
	@Override
	public Map<String, Object> getDaliyReport(StatisticsCond statisticsCond) {
		
		List<RevenueResponse> dailyList = adminStatisticsDAO.findDaliyReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("dailyList", dailyList);
		
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
		
		List<RevenueResponse> monthlyList = adminStatisticsDAO.findMonthlyReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("monthlyList", monthlyList);
		
		return result;
	}

	/* 매출분석(매출 집계) */
	@Override
	public Map<String, Object> getRevenueReport(StatisticsCond statisticsCond) {
		
		List<AggregateResponse> revenueList = adminStatisticsDAO.findRevenueReport(statisticsCond);
		
		Map<String, Object> result = new HashMap<>();
		result.put("revenueList", revenueList);
		
		return result;
	}

/* ----------------------- 상품 분석 -----------------------*/
	
	/* 상품 분석(판매 상품 순위) */
	@Override
	public Map<String, Object> getProductRanking(StatisticsCond statisticsCond) {
		
		StatisticsCond salesQuantityTop10 = StatisticsCond.create(statisticsCond, false, 10);
		StatisticsCond totalSalesTop10 = StatisticsCond.create(statisticsCond, true, 10);
		
		List<ProductRankingResponse> productRankingList = adminStatisticsDAO.findProductRanking(statisticsCond);
		List<ProductRankingResponse> salesQuantityRanking = adminStatisticsDAO.findProductRanking(salesQuantityTop10);
		List<ProductRankingResponse> totalSalesRanking = adminStatisticsDAO.findProductRanking(totalSalesTop10);
		
		Map<String, Object> result = new HashMap<>();
		result.put("productRankingList", productRankingList);
		result.put("salesQuantityList", salesQuantityRanking);
		result.put("totalSalesList", totalSalesRanking);
		
		return result;
	}

	/* 상품 분석(판매 분류 순위) */
	@Override
	public Map<String, Object> getCategoryRanking(StatisticsCond statisticsCond) {
		
		StatisticsCond salesQuantityTop10 = StatisticsCond.create(statisticsCond, false, 10);
		StatisticsCond totalSalesTop10 = StatisticsCond.create(statisticsCond, true, 10);
		
		List<CategoryRankingResponse> categoryRankingList = adminStatisticsDAO.findCategoryRanking(statisticsCond);
		List<CategoryRankingResponse> salesQuantityRanking = adminStatisticsDAO.findCategoryRanking(salesQuantityTop10);
		List<CategoryRankingResponse> totalSalesRanking = adminStatisticsDAO.findCategoryRanking(totalSalesTop10);
		
		Map<String, Object> result = new HashMap<>();
		result.put("categoryRankingList", categoryRankingList);
		result.put("salesQuantityList", salesQuantityRanking);
		result.put("totalSalesList", totalSalesRanking);
		
		return result;
	}

	/* 상품 분석(취소/반품 순위) */
	@Override
	public Map<String, Object> getReturnRanking(StatisticsCond statisticsCond) {
		
		StatisticsCond refundQuantityTop10 = StatisticsCond.create(statisticsCond, 10, false);
		StatisticsCond returnRateTop10 = StatisticsCond.create(statisticsCond, 10, true);
		
		List<ProductRankingResponse> returnRankingList = adminStatisticsDAO.findReturnRanking(statisticsCond);
		List<ProductRankingResponse> refundQuantityRanking = adminStatisticsDAO.findReturnRanking(refundQuantityTop10);
		List<ProductRankingResponse> returnRateRanking = adminStatisticsDAO.findReturnRanking(returnRateTop10);
		
		Map<String, Object> result = new HashMap<>();
		result.put("returnRankingList", returnRankingList);
		result.put("refundQuantityRanking", refundQuantityRanking);
		result.put("returnRateRanking", returnRateRanking);
		
		return result;
	}

	/* 상품 분석(장바구니 상품 분석) */
	@Override
	public Map<String, Object> getCartInfo(StatisticsCond statisticsCond) {
		
		StatisticsCond cartTop10 = StatisticsCond.create(statisticsCond, 10);
		
		List<UserStorageResponse> cartInfoList = adminStatisticsDAO.findCartInfo(statisticsCond);
		List<UserStorageResponse> cartTop10List = adminStatisticsDAO.findCartInfo(cartTop10);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cartInfoList", cartInfoList);
		result.put("cartTop10List", cartTop10List);
		
		return result;
	}

	/* 상품 분석(관심 상품 분석) */
	@Override
	public Map<String, Object> getWishlistInfo(StatisticsCond statisticsCond) {
		
		StatisticsCond WishlistTop10 = StatisticsCond.create(statisticsCond, 10);
		
		List<UserStorageResponse> wishlistInfoList = adminStatisticsDAO.findWishlistInfo(statisticsCond);
		List<UserStorageResponse> WishlistTop10List = adminStatisticsDAO.findWishlistInfo(WishlistTop10);
		
		Map<String, Object> result = new HashMap<>();
		result.put("wishlistInfoList", wishlistInfoList);
		result.put("WishlistTop10List", WishlistTop10List);
		
		return result;
	}

}

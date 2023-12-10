package com.project.service.kkb.admin;

import java.util.Map;

import com.project.vodto.kkb.StatisticsCond;

public interface AdminStatisticsService {
	
	/* 통계 대시보드 */
	Map<String, Object> getDashboardInfo();

/* ----------------------- 매출 분석 -----------------------*/	
	
	/* 매출분석(일별 매출) */
	Map<String, Object> getDaliyReport(StatisticsCond statisticsCond);
	
	/* 매출분석(주별 매출) */
	Map<String, Object> getWeeklyReport(StatisticsCond statisticsCond);

	/* 매출분석(월별 매출) */
	Map<String, Object> getMonthlyReport(StatisticsCond statisticsCond);
	
	/* 매출분석(매출 집계) */
	Map<String, Object> getRevenueReport(StatisticsCond statisticsCond);

/* ----------------------- 상품 분석 -----------------------*/
	
	/* 상품 분석(판매 상품 순위) */
	Map<String, Object> getProductRanking(StatisticsCond statisticsCond);

	/* 상품 분석(판매 분류 순위) */
	Map<String, Object> getCategoryRanking(StatisticsCond statisticsCond);

	/* 상품 분석(취소/반품 순위) */
	Map<String, Object> getReturnRanking(StatisticsCond statisticsCond);

	/* 상품 분석(장바구니 상품 분석) */
	Map<String, Object> getCartInfo(StatisticsCond statisticsCond);

	/* 상품 분석(관심 상품 분석) */
	Map<String, Object> getWishlistInfo(StatisticsCond statisticsCond);
	
}

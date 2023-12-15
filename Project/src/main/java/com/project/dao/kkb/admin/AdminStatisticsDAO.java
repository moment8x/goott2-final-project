package com.project.dao.kkb.admin;

import java.util.List;

import com.project.vodto.kkb.AggregateResponse;
import com.project.vodto.kkb.BestSellerResponse;
import com.project.vodto.kkb.CategoryRankingResponse;
import com.project.vodto.kkb.ProductRankingResponse;
import com.project.vodto.kkb.RevenueResponse;
import com.project.vodto.kkb.StatisticsCond;
import com.project.vodto.kkb.UserStorageResponse;

public interface AdminStatisticsDAO {
	
	/* 베스트셀러 정보 */
	List<BestSellerResponse> findBestSellerInfo();
	
/* ----------------------- 매출 분석 -----------------------*/	
	
	/* 매출분석(일별 매출) */
	List<RevenueResponse> findDaliyReport(StatisticsCond statisticsCond);
	
	/* 매출분석(주별 매출) */
	List<RevenueResponse> findWeeklyReport(StatisticsCond statisticsCond);

	/* 매출분석(월별 매출) */
	List<RevenueResponse> findMonthlyReport(StatisticsCond statisticsCond);
	
	/* 매출분석(매출 집계) */
	List<AggregateResponse> findRevenueReport(StatisticsCond statisticsCond);

/* ----------------------- 상품 분석 -----------------------*/
	
	/* 상품 분석(판매 상품 순위) */
	List<ProductRankingResponse> findProductRanking(StatisticsCond statisticsCond);

	/* 상품 분석(판매 분류 순위) */
	List<CategoryRankingResponse> findCategoryRanking(StatisticsCond statisticsCond);

	/* 상품 분석(취소/반품 순위) */
	List<ProductRankingResponse> findReturnRanking(StatisticsCond statisticsCond);

	/* 상품 분석(장바구니 상품 분석) */
	List<UserStorageResponse> findCartInfo(StatisticsCond statisticsCond);

	/* 상품 분석(관심 상품 분석) */
	List<UserStorageResponse> findWishlistInfo(StatisticsCond statisticsCond);
	
}

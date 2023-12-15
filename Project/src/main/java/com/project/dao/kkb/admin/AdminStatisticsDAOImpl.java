package com.project.dao.kkb.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.kkb.AggregateResponse;
import com.project.vodto.kkb.BestSellerResponse;
import com.project.vodto.kkb.CategoryRankingResponse;
import com.project.vodto.kkb.ProductRankingResponse;
import com.project.vodto.kkb.RevenueResponse;
import com.project.vodto.kkb.StatisticsCond;
import com.project.vodto.kkb.UserStorageResponse;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminStatisticsDAOImpl implements AdminStatisticsDAO {

	private static String ns = "com.project.mappers.adminStatisticsMapper";
	private final SqlSession ses;
	
	@Override
	public List<BestSellerResponse> findBestSellerInfo() {
		return ses.selectList(ns + ".selectBestSeller");
	}
	
	@Override
	public List<RevenueResponse> findDaliyReport(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectDaliyReport", statisticsCond);
	}

	@Override
	public List<RevenueResponse> findWeeklyReport(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectWeeklyReport", statisticsCond);
	}

	@Override
	public List<RevenueResponse> findMonthlyReport(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectMonthlyReport", statisticsCond);
	}

	@Override
	public List<AggregateResponse> findRevenueReport(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectRevenueReport", statisticsCond);
	}

	@Override
	public List<ProductRankingResponse> findProductRanking(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectProductRanking", statisticsCond);
	}

	@Override
	public List<CategoryRankingResponse> findCategoryRanking(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectCategoryRanking", statisticsCond);
	}

	@Override
	public List<ProductRankingResponse> findReturnRanking(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectReturnRanking", statisticsCond);
	}

	@Override
	public List<UserStorageResponse> findCartInfo(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectCartInfo", statisticsCond);
	}

	@Override
	public List<UserStorageResponse> findWishlistInfo(StatisticsCond statisticsCond) {
		return ses.selectList(ns + ".selectWishlistInfo", statisticsCond);
	}

}

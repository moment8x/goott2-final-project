package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminStockListVO;
import com.project.vodto.kjs.AdminUpdateStockVO;
import com.project.vodto.kjs.AdminProductsSearchVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminProductsDAOImpl implements AdminProductsDAO {
	
	private static String ns = "com.project.mappers.adminProductsMapper";
	private final SqlSession ses;
	
	// ----------------------------- 김상희 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	@Override
	public List<AdminStockListVO> getStockList() {
		return ses.selectList(ns + ".getSearchProductsList");
	}

	@Override
	public int getTotalProductsCount() {
		return ses.selectOne(ns + ".totalProductsCount");
	}

	@Override
	public List<ProductCategory> getCategoryChild(String categoryKey) {
		return ses.selectList(ns + ".getCategoryChild", categoryKey);
	}

	@Override
	public List<AdminStockListVO> getSearchStockList(AdminProductsSearchVO search) {
		return ses.selectList(ns + ".getSearchProductsList", search);
	}

	@Override
	public int updateStock(List<AdminUpdateStockVO> updateStock) {
		return ses.update(ns + ".updateStock", updateStock);
	}

	@Override
	public List<AdminStockListVO> getSoldOutProducts() {
		return ses.selectList(ns + ".getSoldOutProducts");
	}
	// ----------------------------------------------------------------
}
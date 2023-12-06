package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.ProductCategory;
import com.project.vodto.kjs.AdminProductsListVO;
import com.project.vodto.ksh.AdminProductsList;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AdminProductsDAOImpl implements AdminProductsDAO {

	private final SqlSession ses; // db랑 연결해줌

	private static String ns = "com.project.mappers.adminProductsMapper";
	// ----------------------------- 김상희 -----------------------------
	@Override
	public int getProductsOnSaleCount() {
		// 판매 중인 상품 개수
		return ses.selectOne(ns+".getProductsOnSaleCount");
	}
	
	public List<AdminProductsList> getAllProducts(String sellingProducts) {
		return ses.selectList(ns+".getAllProducts");
	}
	// ----------------------------------------------------------------
	// ----------------------------- 김재용 -----------------------------
	
	// ----------------------------------------------------------------
	// ----------------------------- 김진솔 -----------------------------
	// ----------------------------- 김진솔 -----------------------------
	   @Override
	   public List<AdminProductsListVO> getProductsList() {
	      return ses.selectList(ns + ".getProductsList");
	   }

	   @Override
	   public int getTotalProductsCount() {
	      return ses.selectOne(ns + ".totalProductsCount");
	   }

	   @Override
	   public List<ProductCategory> getCategoryChild(String categoryKey) {
	      return ses.selectList(ns + ".getCategoryChild", categoryKey);
	   }

	
	   // ----------------------------------------------------------------
	// ----------------------------------------------------------------
}
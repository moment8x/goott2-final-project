package com.project.vodto.kjs;

import lombok.Getter;

@Getter
public class AdminProductsSearchVO {
	private String searchKey;
	private String searchValue;
	private String categoryKey;
	private String startDate;
	private String endDate;
	private byte bestSellerStatus;
	private String sellingProducts;
	
	private AdminProductsSearchVO(String searchKey, String searchValue, String categoryKey, String startDate, String endDate, byte bestSellerStatus, String sellingProducts) {
		this.searchKey = searchKey;
		this.searchValue = searchValue;
		this.categoryKey = categoryKey;
		this.startDate = startDate;
		this.endDate = endDate;
		this.bestSellerStatus = bestSellerStatus;
		this.sellingProducts = sellingProducts;
	}
	
	private AdminProductsSearchVO(String searchKey, String searchValue, String categoryKey, String startDate, String endDate, byte bestSellerStatus) {
		this.searchKey = searchKey;
		this.searchValue = searchValue;
		this.categoryKey = categoryKey;
		this.startDate = startDate;
		this.endDate = endDate;
		this.bestSellerStatus = bestSellerStatus;
	}
	
	
	public static AdminProductsSearchVO create(String searchKey, String searchValue, String categoryKey,
																		String startDate, String endDate, byte bestSellerStatus, String sellingProducts) {
		searchValue = searchValue.replace(" ", "");
		startDate = startDate.equals("") ? "1000-01-01" : startDate;
		endDate = endDate.equals("") ? "9999-12-31" : endDate;
		
		return new AdminProductsSearchVO(
				searchKey, searchValue, categoryKey, startDate, endDate, bestSellerStatus, sellingProducts);
	}
	
	public static AdminProductsSearchVO create(String searchKey, String searchValue, String categoryKey,
					String startDate, String endDate, byte bestSellerStatus) {
		searchValue = searchValue.replace(" ", "");
		startDate = startDate.equals("") ? "1000-01-01" : startDate;
		endDate = endDate.equals("") ? "9999-12-31" : endDate;
		
		return new AdminProductsSearchVO(
		searchKey, searchValue, categoryKey, startDate, endDate, bestSellerStatus);
}
}
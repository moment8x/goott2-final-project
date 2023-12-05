package com.project.vodto.kkb;

import java.util.List;

import lombok.Getter;

@Getter
public class OrderDetailResponse {
	private List<DetailOrderHistory> orderHistory;
	private List<DetailCancelHistory> cancelHistory;
	private List<DetailExchangeHistory> exchangeHistory;
	private List<DetailReturnHistory> returnHistory;
	private List<DetailRefundHistory> refundHistory;
	private List<DetailSupportHistory> supportHistory;
	
	private OrderDetailResponse(List<DetailOrderHistory> orderHistory, List<DetailCancelHistory> cancelHistory,
			List<DetailExchangeHistory> exchangeHistory, List<DetailReturnHistory> returnHistory,
			List<DetailRefundHistory> refundHistory, List<DetailSupportHistory> supportHistory) {
		this.orderHistory = orderHistory;
		this.cancelHistory = cancelHistory;
		this.exchangeHistory = exchangeHistory;
		this.returnHistory = returnHistory;
		this.refundHistory = refundHistory;
		this.supportHistory = supportHistory;
	}
	
	public static OrderDetailResponse create(List<DetailOrderHistory> orderHistory, List<DetailCancelHistory> cancelHistory,
			List<DetailExchangeHistory> exchangeHistory, List<DetailReturnHistory> returnHistory,
			List<DetailRefundHistory> refundHistory, List<DetailSupportHistory> supportHistory) {
		return new OrderDetailResponse(
				orderHistory, 
				cancelHistory,
				exchangeHistory, 
				returnHistory,
				refundHistory, 
				supportHistory);
	}
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryRankingResponse {
	private int rank;
	private String mainCategory;
	private String subCategory1;
	private String subCategory2;
	private String detailCategory;
	private int paymentQuantity;
	private int refundQuantity;
	private int salesQuantity;
	private int sellingPrice;
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BestSellerResponse {
	private String productImage;
	private String productId;
	private String productName;
	private int sellingPrice;
	private String categoryKey;
}

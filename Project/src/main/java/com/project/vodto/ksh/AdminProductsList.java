package com.project.vodto.ksh;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminProductsList {
	private int no;
	private String productId;
	private String productName;
	private String categoryKey;
	private String categoryName;
	private String productImage;
	private int consumerPrice;
	private int sellingPrice;
	private String url;
}

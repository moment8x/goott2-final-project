package com.project.vodto.kjs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BestSellerVO {
	private String productId;
	private String productName;
	private String sellingPrice;
	private String productImage;
}
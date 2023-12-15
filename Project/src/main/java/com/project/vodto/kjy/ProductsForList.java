package com.project.vodto.kjy;

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
public class ProductsForList {
	private String productId;
	private String productImage;
	private String productName;
	private int consumerPrice;
	private int sellingPrice;
	private float rating;
	private int participationCount;
	private int counts;
	private String publisher;
}

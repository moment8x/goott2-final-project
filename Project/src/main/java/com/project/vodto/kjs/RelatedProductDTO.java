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
public class RelatedProductDTO {
	private String productId;
	private String productName;
	private String productImage;
	private float rating;
	private int consumerPrice;
	private int sellingPrice;
	private String category;
}
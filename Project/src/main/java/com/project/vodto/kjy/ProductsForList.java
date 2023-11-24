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
	private String product_id;
	private String product_image;
	private String product_name;
	private int consumer_price;
	private int selling_price;
	private float rating;
	private int participation_count;
	private int counts;
	private String publisher;
}

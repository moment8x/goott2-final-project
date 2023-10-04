package com.project.vodto;

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
public class Stock {
	private String product_dd;
	private String product_name;
	private int current_quantity;
	private String category_key;
}
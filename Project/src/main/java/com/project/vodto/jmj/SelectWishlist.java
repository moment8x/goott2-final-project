package com.project.vodto.jmj;

import java.sql.Timestamp;

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
public class SelectWishlist {
	private String productId;
	private String productName;
	private int sellingPrice;
	private int consumerPrice;
	private String productImage;
}

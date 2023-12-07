package com.project.vodto.kjs;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminUpdateStockVO {
	private String productId;
	private int newQuantity;
}
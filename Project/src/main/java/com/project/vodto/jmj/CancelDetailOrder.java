package com.project.vodto.jmj;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class CancelDetailOrder {
	private int productPrice;
	private String productId;
	private int detailedOrderId;
	private String reason;
	
}

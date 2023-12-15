package com.project.vodto.jmj;

import java.sql.Timestamp;

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
public class DetailOrder {
	private int productPrice;
	private int productQuantity;
	private String productStatus;
	private String productName;
	private String productImage;
	private String productInvoiceNumber;
	private String productId;
	private int detailedOrderId;
	private String paymentMethod;
	private String deliveryStatus;
	private String categoryKey;
	private int couponDiscount;
}

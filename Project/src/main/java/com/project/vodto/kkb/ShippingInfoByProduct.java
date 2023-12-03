package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
public class ShippingInfoByProduct {
	private Timestamp orderTime;
	private String orderNo;
	private String name;
	private String memberId;
	private String invoiceNumber;
	private String deliveryMessage;
	private List<ShippingInfoProduct> orders;
	
	public ShippingInfoByProduct(Timestamp orderTime, String orderNo, String name, String memberId,
			String invoiceNumber, String deliveryMessage, List<ShippingInfoProduct> orders) {
		this.orderTime = orderTime;
		this.orderNo = orderNo;
		this.name = name;
		this.memberId = memberId;
		this.invoiceNumber = invoiceNumber;
		this.deliveryMessage = deliveryMessage;
		this.orders = orders;
	}
	
	
}

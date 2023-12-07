package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;

@Getter
public class DeliveredInfoByProduct {
	private Timestamp orderTime;
	private String orderNo;
	private String name;
	private String memberId;
	private String invoiceNumber;
	private String deliveryMessage;
	private List<DeliveredInfoProduct> orders;
	
	public DeliveredInfoByProduct(Timestamp orderTime, String orderNo, String name, String memberId,
			String invoiceNumber, String deliveryMessage, List<DeliveredInfoProduct> orders) {
		this.orderTime = orderTime;
		this.orderNo = orderNo;
		this.name = name;
		this.memberId = memberId;
		this.invoiceNumber = invoiceNumber;
		this.deliveryMessage = deliveryMessage;
		this.orders = orders;
	}
}

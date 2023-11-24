package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import com.project.service.kkb.admin.OrderProduct;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class OrderByProduct {
	private Timestamp orderTime;
	private Timestamp paymentTime;
	private String orderNo;
	private String name;
	private String memberId;
	private int actualPaymentAmount;
	private String paymentMethod;
	private String paymentStatus;
	private String deliveryMessage;
	private List<OrderProduct> orders;
}

package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import com.project.service.kkb.admin.ReadyInfoProduct;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ReadyInfoByProduct {
	private Timestamp orderTime;
	private Timestamp paymentTime;
	private String orderNo;
	private String name;
	private String memberId;
	private String productStatus;
	private int actualPaymentAmount;
	private String paymentMethod;
	private String deliveryMessage;
	private List<ReadyInfoProduct> orders;
}

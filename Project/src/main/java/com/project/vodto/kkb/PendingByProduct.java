package com.project.vodto.kkb;

import java.sql.Timestamp;
import java.util.List;

import com.project.service.kkb.admin.PendingProduct;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PendingByProduct {
	private Timestamp orderTime;
	private String orderNo;
	private String name;
	private String memberId;
	private int depositAmount;
	private String bankName;
	private String deliveryMessage;
	private List<PendingProduct> orders;
}

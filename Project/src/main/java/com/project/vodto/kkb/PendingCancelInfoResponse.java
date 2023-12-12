package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PendingCancelInfoResponse {
	private String detailedOrderId;
	private String productId;
	private String productOrderNo;
	private String paymentMethod;
	private String productStatus;
	private int quantity;
	private String cancelId;
}

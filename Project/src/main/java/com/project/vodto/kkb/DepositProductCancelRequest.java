package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositProductCancelRequest {
	private String productOrderNo;
    private String orderNo;
    
    public String getConvertedOrderNo() {
    	orderNo = productOrderNo.split("-")[0];
		return orderNo;
    }
}

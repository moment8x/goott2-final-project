package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositProductCancelRequest {
	private String productOrderNo;
    private String OrderNo;
    
    public String getConvertedOrderNo() {
    	OrderNo = productOrderNo.split("-")[0];
		return OrderNo;
    }
    
    public void setConvertedOrderNo() {
    	OrderNo = productOrderNo.split("-")[0];
    }
}

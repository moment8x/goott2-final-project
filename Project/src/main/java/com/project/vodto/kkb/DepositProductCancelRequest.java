package com.project.vodto.kkb;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositProductCancelRequest {
	private List<String> productOrderNoList;
    private String OrderNo;
    
    public String getConvertedOrderNo() {
    	if (productOrderNoList != null && !productOrderNoList.isEmpty()) {
            OrderNo = productOrderNoList.get(0).split("-")[0];
        }
		return OrderNo;
    }
    
    public void setConvertedOrderNo() {
    	if (productOrderNoList != null && !productOrderNoList.isEmpty()) {
            OrderNo = productOrderNoList.get(0).split("-")[0];
        }
    }
}

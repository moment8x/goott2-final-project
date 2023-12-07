package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductCancelRequest {
	private String productOrderNo;
	private int quantity;
    private String orderNo;
    
    public ProductCancelRequest() {}
    
    private ProductCancelRequest(String productOrderNo) {
		this.productOrderNo = productOrderNo;
	}
    
    public String getConvertedOrderNo() {
    	orderNo = productOrderNo.split("-")[0];
		return orderNo;
    }
    
    public static ProductCancelRequest of(String productOrderNo) {
    	return new ProductCancelRequest(productOrderNo);
    }
}

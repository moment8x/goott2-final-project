package com.project.vodto.jmj;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class CancelListVO {
	 private String productImage;
	 private String productName;
	 private int cancelId;
	 private int amount;
	 private Timestamp requestTime;
	 private String processingStatus;
	 private int detailedOrderId;
	 private String productId;
	 private int returnsId;
	 private String returnShippingAddressZipNo;
	 private String returnShippingAddressAddr;
	 private String returnShippingAddressDetailAddr; 
	 private String returnShippingAddressReturnMsg;
	 private String exchangeShippingAddressZipNo;
	 private String exchangeShippingAddressAddr;
	 private String exchangeShippingAddressDetailAddr;
	 private String exchangeShippingAddressExchangeMsg;
}

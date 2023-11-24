package com.project.vodto.jmj;

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
public class exchangeDTO {
	private String returnZipNo;
	private String returnAddr;
	private String returnDetailAddr;
	private String returnMsg;
	private String exchangeZipNo;
	private String exchangeAddr;
	private String exchangeDetailAddr;
	private String exchangeMsg;
	private int detailedOrderId;
	private String orderNo;
	private String exchangeReason;
}

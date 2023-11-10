package com.project.vodto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ShippingAddress {
	private int addrSeq;
	private String memberId;
	private String zipCode;
	private String address;
	private String detailAddress;
	private char basicAddr;
}
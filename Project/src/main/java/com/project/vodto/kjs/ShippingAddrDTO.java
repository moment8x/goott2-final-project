package com.project.vodto.kjs;

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
public class ShippingAddrDTO {
	private String memberId;
	private String recipient;
	private String recipientContact;
	private String zipCode;
	private String address;
	private String detailAddress;
	private String basicAddr;
}
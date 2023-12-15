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
	private String recipient; //받는사람
	private String recipientContact; //받는사람 연락처
	private String zipCode;
	private String address;
	private String detailAddress;
	private char basicAddr; // 기본배송지 체크여부
}
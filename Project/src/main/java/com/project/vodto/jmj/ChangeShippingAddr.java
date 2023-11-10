package com.project.vodto.jmj;

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
public class ChangeShippingAddr {
	private String recipient;
	private String recipientContact;
	private String zipCode;
	private String address;
	private String detailAddress;
	private String deliveryMessage;
}

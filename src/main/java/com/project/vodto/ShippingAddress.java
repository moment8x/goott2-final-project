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
	private int addr_no;
	private String member_id;
	private String zip_code;
	private String address;
	private String detail_address;
	private char basic_addr;
}
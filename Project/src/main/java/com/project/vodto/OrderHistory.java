package com.project.vodto;

import java.sql.Timestamp;

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
public class OrderHistory {
	private int order_no;
	private String member_id;
	private String invoice_number;
	private String recipient_name;
	private String recipient_phone_number;
	private Timestamp order_time;
	private String zip_code;
	private String shipping_address;
	private String detailed_shipping_address;
	private String delivery_status;
	private String delivery_message;
}
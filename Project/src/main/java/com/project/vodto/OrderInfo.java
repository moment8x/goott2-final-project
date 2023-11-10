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
public class OrderInfo {
	private String product_id;
	private String product_name;
	private String product_image;
	private String category_key;
	private int product_quantity;
	private int current_quantity;
	private int calculated_price;
	private int selling_price;
	private int total_amount;
	private int actual_payment_amount;
	private int discount_amount; // 수동으로 넣어줘야함
	private String resipient_name;
	private String recipient_phone_number;
	private String shipping_address;
	private String detailed_shipping_address;
	private String card_name;
	private String adequacy;
	
}

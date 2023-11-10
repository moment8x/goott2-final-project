package com.project.vodto;

import java.sql.Timestamp;
import java.util.List;

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
public class PaymentDTO {
	private String payment_number;
	private int order_no;
	private String non_order_no;
	private String payment_method;
	private int total_amount;
	private int shipping_fee;
	private int used_reward;
	private int used_points;
	private int actual_payment_amount;
	private Timestamp payment_time;
	private int amount_to_pay;
//	private List<String> product_id;
//	private List<Integer> product_price;// quantity
	private List<DetailOrderItem> products;
	private String card_name;
	private String card_number;
	private String recipient_name;
	
}

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
public class Payment {
	private String payment_number;
	private int order_no;
	private int non_order_no;
	private String payment_method;
	private String total_amount;
	private int shipping_fee;
	private int used_reward;
	private int used_points;
	private String actual_payment_amount;
	private Timestamp payment_time;
}
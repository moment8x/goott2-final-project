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
public class Refund {
	private int refund_no;
	private String product_id;
	private Timestamp refund_application_date;
	private Timestamp refund_processing_completion_date;
	private int refund_number;
	private int total_refund_amount;
	private int actual_refund_amount;
	private int refund_reward_used;
	private int refund_point_used;
	private char refund_processing_detail;
	private String refund_information;
}
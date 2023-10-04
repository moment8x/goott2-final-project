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
public class Return {
	private int return_no;
	private String product_id;
	private String reason;
	private String processing_status;
	private Timestamp request_time;
	private Timestamp completion_time;
	private int refund_status;
}
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
public class CouponLog {
	private int no;
	private String member_id;
	private String coupon_number;
	private String coupon_name;
	private Timestamp obtained_date;
	private Timestamp used_date;
}
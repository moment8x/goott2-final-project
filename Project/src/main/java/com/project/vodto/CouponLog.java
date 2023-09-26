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
	private String memberId;
	private String couponNumber;
	private String couponname;
	private Timestamp obtainedDate;
	private Timestamp usedDate;
}
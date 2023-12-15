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
	private int couponLogsSeq;
	private String memberId;
	private String couponNumber;
	private String couponName;
	private Timestamp obtainedDate; //얻은 날짜
	private Timestamp usedDate;
	private Timestamp expirationDate; //만료 날짜
}
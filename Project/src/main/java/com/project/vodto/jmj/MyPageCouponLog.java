package com.project.vodto.jmj;

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
public class MyPageCouponLog {
	private int couponLogsSeq;
	private String memberId;
	private Timestamp obtainedDate; //얻은 날짜
	private Timestamp usedDate;
	private Timestamp expirationDate; //만료 날짜
	private String couponNumber;
	private int discountAmount; //할인율(금액)
	private int termOfValidity; //사용가능한 기간?
	private String couponName;
}

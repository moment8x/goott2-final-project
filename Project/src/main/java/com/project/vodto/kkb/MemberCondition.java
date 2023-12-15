package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberCondition {
	private String ageStart;
	private String ageEnd;
	private Date registrationDateStart;
	private Date registrationDateEnd;
	private String dateOfBirthStart;
	private String dateOfBirthEnd;
	private String name;
	private String email;
	private String memberId;
	private String membershipGrade;
	private String phoneNumber;
	private String cellPhoneNumber;
	private Character gender;
	private String address;
	private String detailedAddress;
	private String orderAmountStart;
	private String orderAmountEnd;
	private String actualPaymentAmountStart;
	private String actualPaymentAmountEnd;
	private String orderCountStart;
	private String orderCountEnd;
	private String actualOrderCountStart;
	private String actualOrderCountEnd;
	private String orderDateStart;
	private String orderDateEnd;
	private String paymentDateStart;
	private String paymentDateEnd;
	private String orderItem;
	private String totalRewardsStart;
	private String totalRewardsEnd;
	private String totalPointsStart;
	private String totalPointsEnd;
	private Date lastLoginDateStart;
	private Date lastLoginDateEnd;
	private Character dormantAccount;
}

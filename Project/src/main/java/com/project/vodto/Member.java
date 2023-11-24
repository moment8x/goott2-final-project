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
public class Member {
	private String memberId;
	private String password;
	private String name;
	private String phoneNumber; //전화번호
	private String cellPhoneNumber; // 핸드폰번호
	private Timestamp registrationDate;
	private char gender;
	private String dateOfBirth;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private String email;
	private char identityVerificationStatus;
	private String membershipGrade;
	private int totalPoints;
	private int totalRewards;
	private int couponCount;
	private int profileImage;
	private String remember;
	private Timestamp lastLoginDate;
	private String refundBank;
	private String refundAccount;
	private String accountHolder; //예금주
	private String dormantAccout; //휴면계정
	private String memberToken;
	private String permission; //권한 등급
	private String withdraw; //탈퇴여부
	private int accumulatedReward;
	private int accumulatedUseReward;
	private int accumulatedPoint;
	private int accumulatedUsePoint;
	private int accumulatedPayment;
}
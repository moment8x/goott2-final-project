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
	private String phoneNumber;
	private String cellPhoneNumber;
	private Timestamp registertaionDate;
	private char gender;
	private String dateOfBirth;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private String email;
	private char identityVerificationStatus;
	private String membershipGrade;
	private int totalPoints;
	private int totalReward;
	private int couponCount;
	private int profileImage;
	private int remember;
	private Timestamp lastLoginDate;
	private String refundBank;
	private String refundAccount;
	private String dormantAccout;
	private String memberToken;
	private String permission;
}
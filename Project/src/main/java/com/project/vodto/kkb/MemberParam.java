package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberParam {
	private String memberId;
	private String password;
	private String name;
	private String phoneNumber; 
	private String cellPhoneNumber; 
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
	private int totalReward;
	private int couponCount;
	private int profileImage;
	private String remember;
	private Timestamp lastLoginDate;
	private String refundBank;
	private String refundAccount;
	private String dormantAccout; 
	private String memberToken;
	private String permission; 
	private String withdraw; 
	private String accountHolder;
}

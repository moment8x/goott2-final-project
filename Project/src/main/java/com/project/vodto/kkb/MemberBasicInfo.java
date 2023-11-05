package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@ToString
public class MemberBasicInfo {
	private String memberId;
	private String name;
	private String phoneNumber; 
	private String cellPhoneNumber; 
	private char gender;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private String email;
	private char identityVerificationStatus;
	private String membershipGrade;
	private int totalPoints;
	private int totalReward;
	private String dormantAccout; 
	private String permission; 
	private String withdraw;
}

package com.project.vodto.kkb;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberUpdateCond {
	private String memberId;
	private String password;
	private String name;
	private String phoneNumber; 
	private String cellPhoneNumber; 
	private char gender;
	private String dateOfBirth;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private String email;
	private String membershipGrade;
	private int profileImage;
	private String refundBank;
	private String refundAccount;
	private String accountHolder;
}

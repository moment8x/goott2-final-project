package com.project.vodto.kjs;

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
public class SignUpDTO {
	private String memberId;
	private String password;
	private String name;
	private String phoneNumber; //전화번호
	private String cellPhoneNumber;
	private char gender;
	private String dateOfBirth;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private String email;
	private char identityVerificationStatus;
	private int profileImage;
	private String refundBank;
	private String refundAccount;
	private String basicAddr;
}
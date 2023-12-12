package com.project.vodto.kjs;

import java.util.List;

import com.project.vodto.UploadFiles;

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
	private String email;
	private String phoneNumber;
	private String phoneNumber1; //전화번호
	private String phoneNumber2;
	private String phoneNumber3;
	private String cellPhoneNumber;
	private String cellPhoneNumber1; // 핸드폰번호
	private String cellPhoneNumber2; // 핸드폰번호
	private String cellPhoneNumber3; // 핸드폰번호
	private String dateOfBirth;
	private String gender;
	private String zipCode;
	private String address;
	private String detailedAddress;
	private int profileImage;
	private String refundBank;
	private String refundAccount;
	private String basicAddr;
	List<UploadFiles> fileList;
}
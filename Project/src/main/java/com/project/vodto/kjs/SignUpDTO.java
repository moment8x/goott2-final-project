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
	private String cellPhoneNumber;
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
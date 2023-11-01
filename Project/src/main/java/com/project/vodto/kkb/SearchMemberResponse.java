package com.project.vodto.kkb;

import lombok.Data;

@Data
public class SearchMemberResponse {
	private String registrationDate;
	private String name;
	private String memberId;
	private String membershipGrade;
	private String phoneNumber;
	private String cellPhoneNumber;
	private Character gender;
	private String dateOfBirth;
	private String age;
	private String address;
	private String region;
}

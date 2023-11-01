package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchMemberRequest {
	private String ageStart;
	private String ageEnd;
	private Date registrationDate;
	private Date registrationDateStart;
	private Date registrationDateEnd;
	private String dateOfBirth;
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
}

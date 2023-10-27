package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class SearchMemberResponse {
	private String registrationDate;
	private String name;
	private String memberId;
	private String membershipGrade;
	private String phoneNumber;
	private String cellPhoneNumber;
	private Character gender;
	private String age;
	private String region;
}

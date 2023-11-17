package com.project.vodtokjy;

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
public class Member1 {
	private String member_id;
	private String password;
	private String name;
	private String phone_number;
	private Timestamp registertaion_date;
	private char gender;
	private String date_of_birth;
	private String zip_code;
	private String address;
	private String detailed_address;
	private String email;
	private char identity_verification_status;
	private char adult_verification_status;
	private char recive_advertising;
	private String membership_grade;
	private int total_points;
	private int total_reward;
	private int coupon_count;
	private int profile_image;
	private String remember;
	private Timestamp last_login_date;
	private String refund_bank;
	private String refund_account;
	private String dormant_accout;
	private String member_token;
	private String Privilege;
}
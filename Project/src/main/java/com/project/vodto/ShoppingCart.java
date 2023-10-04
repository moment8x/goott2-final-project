package com.project.vodto;

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
public class ShoppingCart {
	private int no;
	private String nonMember_id;
	private String member_id;
	private String product_id;
	private int member_check;
	private Timestamp registration_date;
}
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
public class Wishlist {
	private int wishlist_no;
	private String member_id;
	private String product_id;
	private Timestamp registration_date;
	private String category_key;
}
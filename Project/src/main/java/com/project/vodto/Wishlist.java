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
	private int wishlistSeq;
	private String memberId;
	private String productId;
	private Timestamp registrationDate;
	private String categoryKey;
}
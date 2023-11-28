package com.project.vodto.jmj;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class MyPageReview {
	private int postNo;
	private Timestamp createdDate;
	private String content;
	private int rating;
	private String productId;
	private String isDelete;
	private String productImage;
	private String productName;
}

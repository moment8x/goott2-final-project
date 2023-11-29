package com.project.vodto.kjs;

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
public class ShowCartDTO {
	private String memberId;
	private String productId;
	private String nonMemberId;
	private String productImage;
	private String productName;
	private int sellingPrice;
	private int quantity;
}
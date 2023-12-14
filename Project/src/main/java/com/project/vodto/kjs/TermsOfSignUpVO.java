package com.project.vodto.kjs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
public class TermsOfSignUpVO {
	private String termsType;
	private String termsContent;
}
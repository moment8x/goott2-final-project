package com.project.exception.kkb;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ErrorResult {
	private String name;
	private String messageEn;
	private String messageKr;
}

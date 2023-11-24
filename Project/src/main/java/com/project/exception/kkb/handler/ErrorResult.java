package com.project.exception.kkb.handler;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ErrorResult {
	private String code;
	private String message;
}

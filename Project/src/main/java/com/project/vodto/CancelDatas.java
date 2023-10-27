package com.project.vodto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import lombok.Setter;

import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
public class CancelDatas {
	private String imp_uid;

	private BigDecimal amount;

	private BigDecimal checksum;

	private String reason;
}

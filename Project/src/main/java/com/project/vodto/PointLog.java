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
public class PointLog {
	private int pointLogsSeq;
	private String memberId;
	private Timestamp date;
	private String reason;
	private int point;
	private String relatedOrder;
	private int balance;
}
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
public class RewardLog {
	private int rewardLogsSeq;
	private String memberId;
	private Timestamp date;
	private int reward;
	private String relatedOrder;
	private int balance;
	private String reason;
}
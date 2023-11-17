package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RewardListResponse {
	private String reason;
	private Timestamp date;
	private int reward;
	private int balance;
	private String relatedOrder;
}

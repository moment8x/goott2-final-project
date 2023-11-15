package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PointListResponse {
	private String reason;
	private Timestamp date;
	private int point;
	private int balance;
	private String relatedOrder;
}

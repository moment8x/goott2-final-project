package com.project.vodto.kkb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PointResponse {
	private String reason;
	private Timestamp date;
	private int point;
	private int totalPoint;
	private String relatedOrder;
}

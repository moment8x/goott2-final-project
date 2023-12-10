package com.project.vodto.kkb;

import java.sql.Date;

import lombok.Getter;

@Getter
public class StatisticsCond {
	private Date dateStart;
	private Date dateEnd;
	private int limit;
	private boolean isReturnRateRanking;
	
	private StatisticsCond(Date dateStart, Date dateEnd, int limit, boolean isReturnRateRanking) {
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.limit = limit;
		this.isReturnRateRanking = isReturnRateRanking;
	}
	
	private StatisticsCond(Date dateStart, Date dateEnd) {
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
	}
	
	private StatisticsCond(Date dateStart, Date dateEnd, int limit) {
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.limit = limit;
	}
	
	public static StatisticsCond create(String dateStart, String dateEnd) {
		
		dateStart = dateStart.equals("") ? "0000-01-01" : dateStart;
		dateEnd = dateEnd.equals("") ? "9999-12-31" : dateEnd;
		
		return new StatisticsCond(
				Date.valueOf(dateStart), 
				Date.valueOf(dateEnd));
	}
	
	public static StatisticsCond create(String dateStart, String dateEnd, int limit) {
		
		dateStart = dateStart.equals("") ? "0000-01-01" : dateStart;
		dateEnd = dateEnd.equals("") ? "9999-12-31" : dateEnd;
		
		return new StatisticsCond(
				Date.valueOf(dateStart), 
				Date.valueOf(dateEnd),
				limit);
	}

	public static StatisticsCond create(String dateStart, String dateEnd, int limit, boolean isReturnRateRanking) {
	
	dateStart = dateStart.equals("") ? "0000-01-01" : dateStart;
	dateEnd = dateEnd.equals("") ? "9999-12-31" : dateEnd;
	
	return new StatisticsCond(
			Date.valueOf(dateStart), 
			Date.valueOf(dateEnd),
			limit,
			isReturnRateRanking);
}
}

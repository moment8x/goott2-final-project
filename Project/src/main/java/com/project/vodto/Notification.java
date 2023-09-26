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
public class Notification {
	private int key;
	private String memberId;
	private String link;
	private String notificationTitle;
	private String notificationContent;
	private Timestamp date;
	private Timestamp expirationDate;
	private int readStatus;
}
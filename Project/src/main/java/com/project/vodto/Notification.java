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
	private String member_id;
	private String link;
	private String notification_title;
	private String notification_content;
	private Timestamp date;
	private Timestamp expiration_date;
	private int read_status;
}
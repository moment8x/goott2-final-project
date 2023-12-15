package com.project.vodto.kjy;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@AllArgsConstructor
@ToString
public class Reply {
	private int postNo;
	private String author;
	private Timestamp createdDate;
	private String content;
	private int ref;
	private List<String> thumbnailFileName;
}

package com.project.vodto.ksh;

import java.sql.Timestamp;
import java.util.List;

import com.project.vodto.UploadFiles;

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
public class CustomerInquiryDTO {
	private int postNo;
	private String author;
	private Timestamp createdDate;
	private String title;
	private String content;
	private String answerStatus;
	private int ref;
	private int step;
	private int refOrder;
	private Timestamp answerDate;
	private String inquiryType;
	private String phoneNumber;
	private String email;
	private String orderNo;
	private int uploadFilesSeq;
	private List<UploadFiles> objList;
	private List<UploadFiles> deleteList;
	private String inquirySms;
	
}
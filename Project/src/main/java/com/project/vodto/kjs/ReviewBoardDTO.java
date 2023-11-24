package com.project.vodto.kjs;

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
public class ReviewBoardDTO {
	private int postNo;
	private String author;
	private Timestamp createdDate;
	private String content;
	private int ref;
	private int step;
	private int ref_order;
	private int likes;
	private int rating;
	private String productId;
	private List<UploadFiles> images;
	private List<String> imagesAddr;
}

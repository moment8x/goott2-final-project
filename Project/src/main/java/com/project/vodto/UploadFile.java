package com.project.vodto;

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
public class UploadFile {
	private int ufSeq;
	private String thumbnailFileName;
	private String extension;
	private String originalFileName;
	private String newFileName;
	private int fileSize;
}
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
public class UploadFiles {
	private int uploadFilesSeq;
	private String thumbnailFileName;
	private String extension;
	private String originalFileName;
	private String newFileName;
	private long fileSize;
	
	public UploadFiles(String originalFileName, long fileSize) {
		this.originalFileName = originalFileName;
		this.fileSize = fileSize;
	}
}
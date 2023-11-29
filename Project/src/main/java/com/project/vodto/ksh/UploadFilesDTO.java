package com.project.vodto.ksh;

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
public class UploadFilesDTO {
	private int uploadFilesSeq;
	private String thumbnailFileName;
	private String extension;
	private String originalFileName;
	private String newFileName;
	private long fileSize;
	private int existingFile;
}
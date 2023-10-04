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
	private int uf_no;
	private String thumbnail_fileName;
	private String extension;
	private String original_fileName;
	private String new_file_name;
	private int file_size;
}
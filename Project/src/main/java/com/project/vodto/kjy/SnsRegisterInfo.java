package com.project.vodto.kjy;

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
public class SnsRegisterInfo {
	private String id;
	private String email;
	private String mobile;
	private String name;
	private String birthday;
	private String birthyear;
	private String mobile_e164;
	private String connected_at;
}

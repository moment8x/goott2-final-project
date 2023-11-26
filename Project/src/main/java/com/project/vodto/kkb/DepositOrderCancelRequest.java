package com.project.vodto.kkb;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepositOrderCancelRequest {
	private List<String> orderNoList;
}
